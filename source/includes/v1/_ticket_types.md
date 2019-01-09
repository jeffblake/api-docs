# Ticket types

Ticket types are composed of two data models: ticket type, and event ticket type. A ticket type is a standalone entity that can be re-used for many different events.
An event ticket type associates a ticket type to a specific event.

See [**Objects**](#objects-ticket-type) section for details on the fields and relationships.

## List ticket types

<div class="api-endpoint">
	<div class="endpoint-data">
		<i class="label label-get">GET</i>
		<h6>/ticket_types</h6>
	</div>
</div>

> List ticket types

```shell
curl -X GET \
  https://app.guestmanager.com/api/public/v2/ticket_types \
  -H 'Authorization: Token abcdefg' \
  -H 'Content-Type: application/json' \
```

> Response

```json
{
    "data": [
        {
            "id": 4104,
            "created_at": "2018-03-27T04:37:10.171834Z",
            "updated_at": "2019-01-02T23:07:04.834997Z",
            "archived_at": null,
            "name": "GA",
            "pdf_template_id": 8355,
            "wallet_template_id": null,
            "attachable": true,
            "transferable": true,
            "include_name": false,
            "include_email": false,
            "require_name": false,
            "require_email": false,
            "enforce_barcode_pool": false,
            "attachment_name": "{{ticket.name}}"
        },
        ...
    ],
    "meta": {
        "count": 5,
        "total": 5,
        "page": {
            "number": 1,
            "size": 10,
            "next": null,
            "prev": null,
            "total": 1,
            "last": true,
            "first": true,
            "out_of_range": false
        },
        "links": {
            "self": "https://app.guestmanager.com/api/public/v2/ticket_types",
            "next": null,
            "prev": null,
            "first": "https://app.guestmanager.com/api/public/v2/ticket_types?page%5Bnumber%5D=1",
            "last": "https://app.guestmanager.com/api/public/v2/ticket_types?page%5Bnumber%5D=1"
        }
    }
}
```

### Request parameters

Parameter                        | Type        | Required | Default   | Description
-------------------------------- | ----------- | -------- | --------- | -----------
`page[size]`                     | `integer`   | *no*     | `10`      | How many records to return per request. Default is `10`, maximum is `100`
`page[number]`                   | `integer`   | *no*     | `1`       | The page of records to request.
`sort[{field}]`                  | `string`    | *no*     | *none*    | Replace `{field}` with one of `id`, `created_at`, `updated_at`, `name`, and set the value to `asc` or `desc`. You may specify multiple sort fields.
`fields`                         | `string`    | *no*     | `all`     | Comma separated list of attributes to return.
`include`                        | `string`    | *no*     | *none*    | Relationships to include.


## Create ticket type

<div class="api-endpoint">
	<div class="endpoint-data">
		<i class="label label-post">POST</i>
		<h6>/ticket_types</h6>
	</div>
</div>

> Create basic ticket type and add it to event

```shell
curl -X POST \
  https://app.guestmanager.com/api/public/v2/ticket_types/ \
  -H 'Authorization: Token abcdefg' \
  -H 'Content-Type: application/json' \
  -d '{
	"ticket_type": {
		"name": "GA"
	}
}'
```

> Response

```json
{
  "id": 7456,
  "created_at": "2019-01-07T21:56:42.755038Z",
  "updated_at": "2019-01-07T21:56:42.774215Z",
  "archived_at": null,
  "name": "GA",
  "pdf_template_id": null,
  "wallet_template_id": null,
  "attachable": true,
  "transferable": true,
  "include_name": false,
  "include_email": false,
  "require_name": false,
  "require_email": false,
  "enforce_barcode_pool": false,
  "attachment_name": "{{ticket.name}}"
}
```

### Request parameters

Parameter                                    | Type         | Required | Default    | Description
-------------------------------------------- | ------------ | -------- | ---------- | ------------------------
`ticket_type[name]`                          | `string`     | *yes*    |            | Name of the ticket type.
`ticket_type[display_name]`                  | `string`     | *no*     |            | Display name.
`ticket_type[pdf_template_id]`               | `string`     | *no*     | `null`     | Ticket design template ID.
`ticket_type[wallet_template_id]`            | `string`     | *no*     | `null`     | Apple Wallet design template ID.
`ticket_type[attachable]`                    | `boolean`    | *no*     | `true`     | `true` to include ticket as a PDF attachment, `false` to include as a download link instead.
`ticket_type[transferable]`                  | `boolean`    | *no*     | `true`     | Whether guests can transfer their ticket to someone else.
`ticket_type[include_name]`                  | `boolean`    | *no*     | `false`    | See object reference.
`ticket_type[require_name]`                  | `boolean`    | *no*     | `false`    | See object reference.
`ticket_type[include_email]`                 | `boolean`    | *no*     | `false`    | See object reference.
`ticket_type[require_email]`                 | `boolean`    | *no*     | `false`    | See object reference.
`ticket_type[enforce_barcode_pool]`          | `boolean`    | *no*     | `false`    | See object reference.


## Fetch ticket type

<div class="api-endpoint">
	<div class="endpoint-data">
		<i class="label label-get">GET</i>
		<h6>/ticket_types/{id}</h6>
	</div>
</div>

> Fetch ticket type

```shell
curl -X GET \
  https://app.guestmanager.com/api/public/v2/ticket_types/7456 \
  -H 'Authorization: Token abcdefg' \
  -H 'Content-Type: application/json' \
```

> Response

```json
{
    "id": 7456,
    "created_at": "2019-01-07T21:56:42.755038Z",
    "updated_at": "2019-01-07T21:56:43.048201Z",
    "archived_at": null,
    "name": "GA",
    "display_name": null,
    "pdf_template_id": null,
    "wallet_template_id": null,
    "attachable": true,
    "transferable": true,
    "include_name": false,
    "include_email": false,
    "require_name": false,
    "require_email": false,
    "enforce_barcode_pool": false,
    "attachment_name": "{{ticket.name}}"
}
```


### Request parameters
None.

## Update ticket type

<div class="api-endpoint">
	<div class="endpoint-data">
		<i class="label label-patch">PATCH</i>
		<h6>/ticket_types/{id}</h6>
	</div>
</div>

> Update ticket type

```shell
curl -X PATCH \
  https://app.guestmanager.com/api/public/v2/ticket_types/7456 \
  -H 'Authorization: Token abcdefg' \
  -H 'Content-Type: application/json' \
  -d '{
	"ticket_type": {
		"name": "New name"
	}
}'
```

### Request parameters
See parameters in create ticket type endpoint.

## Delete ticket type

<div class="api-endpoint">
	<div class="endpoint-data">
		<i class="label label-delete">DELETE</i>
		<h6>/ticket_types/{id}</h6>
	</div>
</div>

> Delete ticket type

```shell
curl -X DELETE \
  https://app.guestmanager.com/api/public/v2/ticket_types/7456 \
  -H 'Authorization: Token abcdefg' \
  -H 'Content-Type: application/json' \
```

> Response (204) No Content


### Request parameters
None.