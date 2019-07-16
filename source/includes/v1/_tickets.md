# Tickets

See [**Objects**](#objects-ticket) section for details on the fields and relationships.

## List tickets

### Request

<div class="api-endpoint">
	<div class="endpoint-data">
		<i class="label label-get">GET</i>
		<h6>/tickets</h6>
	</div>
</div>

> List tickets for specific event

```shell
curl -X GET \
  https://app.guestmanager.com/api/public/v2/tickets \
  -H 'Authorization: Token abcedfg' \
  -H 'Content-Type: application/json' \
  -d '{
	"filter": {
		"event_ids": "1234"
	}
  }'
```

#### Parameters

Parameter                        | Type        | Required | Default   | Description
-------------------------------- | ----------- | -------- | --------- | -----------
`page[size]`                     | `integer`   | *no*     | `10`      | How many records to return per request. Default is `10`, maximum is `50`
`page[number]`                   | `integer`   | *no*     | `1`       | The page of records to request.
`sort[{field}]`                  | `string`    | *no*     | *none*    | Replace `{field}` with one of `id`, `created_at`, `updated_at`, and set the value to `asc` or `desc`. You may specify multiple sort fields.
`fields`                         | `string`    | *no*     | `id,name` | Comma separated list of attributes to return.
`include`                        | `string`    | *no*     | *none*    | Relationships to include.
`filter[event_ids]`              | `string`    | *no*     | *none*    | Filter by event. Comma separated string of event IDs.
`filter[list_ids]`               | `string`    | *no*     | *none*    | Filter by event lists. Comma separated string of IDs.


## Fetch ticket

### Request

<div class="api-endpoint">
	<div class="endpoint-data">
		<i class="label label-get">GET</i>
		<h6>/tickets/{id}</h6>
	</div>
</div>

> Fetch ticket

```shell
curl -X GET \
  https://app.guestmanager.com/api/public/v2/tickets/2307131 \
  -H 'Authorization: Token abcedfg' \
  -H 'Content-Type: application/json' \
```

#### Parameters

No parameters.

## Create ticket

* You need to know the ticket type and event ID to create a ticket. An `event_ticket_type_id` is preferred, as it knows both the ticket type and event ID.
* For de-normalization purposes, `event_id` and `ticket_type_id` are saved to the database, however both attributes can be derived from the `event_ticket_type_id` (the join table containing both `event_id` and `ticket_type_id`)

###  Request

<div class="api-endpoint">
	<div class="endpoint-data">
		<i class="label label-post">POST</i>
		<h6>/tickets</h6>
	</div>
</div>

> Request (Barebones ticket)

```shell
curl -X POST \
  https://app.guestmanager.com/api/public/v2/tickets \
  -H 'Authorization: Token abbcdefg' \
  -H 'Content-Type: application/json' \
  -d '{
    "ticket": {
        "event_ticket_type_id": 19054
    }
}'

```

> Response (Barebones ticket)

```json
{
    "id": 2589825,
    "number": "eqRNGyHe9eygZJy4nYpHf6Qx",
    "status": "valid",
    "name": null,
    "email": null,
    "barcode_id": "0574501952988944",
    "note": null,
    "event_id": 71389,
    "ticket_type_id": 3937,
    "event_ticket_type_id": 19054,
    "list_id": 1016743,
    "source_id": null,
    "source_type": null,
    "contact_id": null,
    "dispatched_at": null,
    "downloaded_at": null,
    "checkin_at": null,
    "guest": null,
    "links": {
        "pdf": "https://client.guestmanager.com/tickets/pMWFB5yZ6yasd3idtoJE7pfCfc.pdf",
        "wallet": null
    }
}

```

> Create and email ticket

```shell
curl -X POST \
  https://app.guestmanager.com/api/public/v2/tickets \
  -H 'Authorization: Token abcedg' \
  -H 'Content-Type: application/json' \
  -d '{
    "ticket": {
        "event_ticket_type_id": 19054,
        "name": "Jeff Blake",
        "email": "jeff@guestmanager.com",
        "dispatch": true
    }
}'
# Inspect response carefully: An invalid email or un-configured Ticket design will trigger error `422`
# `dispatched_at` will return null, but will be updated asynchronously upon successful email delivery
```

> Create ticket assigned to contact

```shell
# This method is preferred over specifying a ticket name and email, as it associates the ticket to an existing contact record.
curl -X POST \
  https://app.guestmanager.com/api/public/v2/tickets \
  -H 'Authorization: Token abcdefg' \
  -H 'Content-Type: application/json' \
  -d '{
    "ticket": {
        "event_ticket_type_id": 19054,
        "contact_id": 1384595
    }
}'
```

> Response


```json
{
    "id": 2589827,
    "number": "JQ2WDaYZwzgXXZ9MDr3uSm7E",
    "status": "valid",
    "name": null,
    "email": null,
    "barcode_id": "8710305528892125",
    "note": null,
    "event_id": 71389,
    "ticket_type_id": 3937,
    "event_ticket_type_id": 19054,
    "list_id": 1016743,
    "source_id": null,
    "source_type": null,
    "contact_id": 1384595,
    "dispatched_at": null,
    "downloaded_at": null,
    "checkin_at": null,
    "contact": {
        "id": 1384595,
        "identifier": null,
        "name": "Mandy Jones",
        "first_name": "Mandy",
        "last_name": "Jones",
        "email": "****@hotmail.com"
    },
    "links": {
        "pdf": "https://client.guestmanager.com/tickets/pMWFB5yZas3fdtoJE7pfCfc.pdf",
        "wallet": null
    }
}
```

> Create ticket with custom fields (specifying `field_id`)

```shell
curl -X POST \
  https://app.guestmanager.com/api/public/v2/tickets \
  -H 'Authorization: Token abcdefg' \
  -H 'Content-Type: application/json' \
  -d '{
    "ticket": {
        "event_ticket_type_id": 19054,
        "contact_id": 1384595,
        "custom_fields": [
          {
            "field_id": 12345,
            "value": "a custom field"
          }
        ]
    }
}'
```

> Create ticket with custom fields (specifying `label`)

```shell
curl -X POST \
  https://app.guestmanager.com/api/public/v2/tickets \
  -H 'Authorization: Token abcdefg' \
  -H 'Content-Type: application/json' \
  -d '{
    "ticket": {
        "event_ticket_type_id": 19054,
        "contact_id": 1384595,
        "custom_fields": [
          {
            "label": "Title",
            "value": "CEO"
          },
          {
            "label": "Company",
            "value": "ACME Inc."
          }
        ]
    }
}'
```

#### Parameters
Parameter                          | Type        | Required                                                  | Description
---------------------------------- | ----------- | --------------------------------------------------------- | -------------------------
`ticket[name]`                     | `string`    | No                                                        | Name to be shown on the ticket. Automatically set if `contact_id` is provided.
`ticket[email]`                    | `string`    | No                                                        | Email address of the ticket owner. Automatically set if `contact_id` is provided.
`ticket[contact_id]`               | `int`       | No                                                        | Link a guest in your database as the owner of this ticket.
`ticket[event_ticket_type_id]`     | `int`       | No, if both `event_id` and `ticket_type_id` are provided. | The Ticket Type to assign to the ticket.
`ticket[ticket_type_id]`           | `int`       | No, if `event_ticket_type_id` is provided.                | The ticket type to assign this ticket to.
`ticket[event_id]`                 | `int`       | No, if `event_ticket_type_id` is provided.                | The event to assign this ticket to.
`ticket[dispatch]`                 | `boolean`   | No                                                        | If `true`, an email is dispatched to the owner of the ticket, with the ticket as a PDF attachment.
`ticket[barcode_id]`               | `string`    | No                                                        | A barcode number will be automatically generated if one is not provided.
`ticket[list_id]`                  | `int`       | No                                                        | The list to assign this ticket to. If not provided, defaults to the company master list.
`ticket[permanent_list_id]`        | `int`       | No                                                        | The permanent list. If provided, the event specific `list_id` will be automatically set.
`ticket[custom_fields]`            | `array`     | No                                                        | User defined custom fields. For each object, provide `value` and either `field_id` or `label`. See example.


## Update ticket

### Request

<div class="api-endpoint">
	<div class="endpoint-data">
		<i class="label label-patch">PATCH</i>
		<h6>/tickets/{id}</h6>
	</div>
</div>

> Update ticket

```shell
curl -X PATCH \
  https://app.guestmanager.com/api/public/v2/tickets/2589827 \
  -H 'Authorization: Token abcedfg' \
  -H 'Content-Type: application/json' \
  -d '{
    "ticket": {
        "name": "new name",
        "email": "newemail@gmail.com"
    }
}'
```

> Response

```json
{
    "id": 2589827,
    "number": "JQ2WDaYZwzgXXZ9MDr3uSm7E",
    "status": "valid",
    "name": "New name",
    "email": "newemail@gmail.com",
    "barcode_id": "8710305528892125",
    "note": null,
    "event_id": 71389,
    "ticket_type_id": 3937,
    "event_ticket_type_id": 19054,
    "list_id": 1016743,
    "source_type": null,
    "source_id": null,
    "contact_id": 1384595,
    "dispatched_at": null,
    "downloaded_at": null,
    "checkin_at": null,
    "contact": {
        "id": 1384595,
        "identifier": null,
        "name": "Mandy Jones",
        "first_name": "Mandy",
        "last_name": "Jones",
        "email": "****@hotmail.com"
    },
    "links": {
        "pdf": "https://miele.guestmanager.com/tickets/pMWFB5a3tdNidtoJE7pfCfc.pdf",
        "wallet": null
    }
}
```

#### Parameters

See parameters for create a ticket.

<aside class="warning">
  When updating related objects, such as custom fields, you must specify the <code>id</code> attribute for each object returned to you in the create endpoint. Failure to do so will result
  in duplicate objects being created.

</aside>

## Delete ticket

<div class="api-endpoint">
	<div class="endpoint-data">
		<i class="label label-delete">DELETE</i>
		<h6>/tickets/{id}</h6>
	</div>
</div>

> Request

```shell
curl -X DELETE \
  https://app.guestmanager.com/api/public/v2/tickets/2589827 \
  -H 'Authorization: Token abcedfg' \
  -H 'Content-Type: application/json' \
```

### Response

Successfully deleting a ticket will return response code `204 - No Content` with an empty response body.

## Email ticket
Send an email to the ticket holder containing their ticket (either attached as a PDF, or as a downloadable link, depending on your configuration).

<div class="api-endpoint">
	<div class="endpoint-data">
		<i class="label label-patch">PATCH</i>
		<h6>/tickets/{id}/email</h6>
	</div>
</div>

### Response

Response code     | Successful?   | Description
--------------    | ------------  | -------------
`200`             | Yes           |
`422`             | No            | Common issues: Ticket does not have an email address, or the ticket design has not been configured on the event or ticket type.


> Email ticket

```shell
curl -X PATCH \
  https://app.guestmanager.com/api/public/v2/tickets/2589827/email \
  -H 'Authorization: Token abcedfg' \
  -H 'Content-Type: application/json' \
```

## Email multiple tickets
Send multiple tickets in a single email.

<div class="api-endpoint">
	<div class="endpoint-data">
		<i class="label label-patch">PATCH</i>
		<h6>/tickets/bulk_email</h6>
	</div>
</div>

> Email multiple tickets

```shell
curl -X PATCH \
  https://app.guestmanager.com/api/public/v2/tickets/bulk_email \
  -H 'Accept: */*' \
  -H 'Authorization: Token abcdefg' \
  -H 'Content-Type: application/json' \
  -d '{
    "ids": "2368510,2607936",
	"email": "jeff@test.com",
  "subject": "Custom subject line"
}'
```

> Sample response

```json
{
    "id": 1223527,
    "created_at": "2019-07-16T00:13:14.313530Z",
    "updated_at": "2019-07-16T00:13:14.313530Z",
    "type": "ticket_multiple_email",
    "email": "jeff@test.com",
    "state": "draft",
    "status": "unopened",
    "delivery_error_detail": null,
    "click_count": 0,
    "open_count": 0,
    "subject": "My custom subject",
    "body": null
}
```

### Request parameters
Parameter              | Type                                  | Required     | Description
---------------------- | ------------------------------------- | ------------ | --------------
`ids`                  | `array`, or comma separated `string`  | *yes*        | The ID numbers of the tickets to include in the email.
`email`                | `string`                              | *yes*        | The email address to send the tickets to.
`subject`              | `string`                              | *no*         | Optional custom subject line.
`body`                 | `string`                              | *no*         | Optional custom email body. HTML is supported.
`email_template_id`    | `integer`                             | *no*         | Use a custom pre-created email template (optional).

### Response

Response code     | Successful?   | Description
--------------    | ------------  | -------------
`200`             | Yes           | Email is queued for delivery. an `Email` record is returned in the API call.
`422`             | No            | Invalid ticket ID's, or email address.


## Void ticket
Voiding a ticket will change the status to `invalidated` and send an email to the ticket holder notifying them that their ticket is no longer valid.

<div class="api-endpoint">
	<div class="endpoint-data">
		<i class="label label-patch">PATCH</i>
		<h6>/tickets/{id}/void</h6>
	</div>
</div>

> Void ticket

```shell
curl -X PATCH \
  https://app.guestmanager.com/api/public/v2/tickets/2589827/void \
  -H 'Authorization: Token abcedfg' \
  -H 'Content-Type: application/json' \
```