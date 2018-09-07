# Tickets

## Ticket properties

{TBI}

## Fetch a ticket

### Request

<div class="api-endpoint">
	<div class="endpoint-data">
		<i class="label label-get">GET</i>
		<h6>/tickets/{id}</h6>
	</div>
</div>

#### Parameters

No parameters.

## Create a ticket

###  Request

<div class="api-endpoint">
	<div class="endpoint-data">
		<i class="label label-post">POST</i>
		<h6>/tickets</h6>
	</div>
</div>

#### Parameters
Parameter                          | Type        | Optional                                                   | Description
---------------------------------- | ----------- | ---------------------------------------------------------- | -------------------------
`ticket[name]`                     | `string`    | Yes                                                        | Name to be shown on the ticket. Automatically set if `guest_id` is provided.
`ticket[email]`                    | `string`    | Yes                                                        | Email address of the ticket owner. Automatically set if `guest_id` is provided.
`ticket[guest_id]`                 | `int`       | Yes                                                        | Link a guest in your database as the owner of this ticket.
`ticket[event_ticket_type_id]`     | `int`       | Yes, if both `event_id` and `ticket_type_id` are provided. | The Ticket Type to assign to the ticket.
`ticket[dispatch]`                 | `boolean`   | Yes                                                        | If `true`, an email is dispatched to the owner of the ticket, with the ticket as a PDF attachment.
`ticket[barcode_id]`               | `string`    | Yes                                                        | A barcode number will be automatically generated if one is not provided.
`ticket[list_id]`                  | `int`       | Yes                                                        | The list to assign this ticket to. If not provided, defaults to the company master list.
`ticket[permanent_list_id]`        | `int`       | Yes                                                        | The permanent list. If provided, the event specific `list_id` will be automatically set.
`ticket[event_id]`                 | `int`       | Yes, if `event_ticket_type_id` is provided.                | The event to assign this ticket to.
`ticket[ticket_type_id]`           | `int`       | Yes, if `event_ticket_type_id` is provided.                | The ticket type to assign this ticket to.


> Standalone ticket

```json
{
  "ticket": {
    "name": "Jeff Blake"
    "email": "jeff@guestmanager.com"
    "event_ticket_type_id": 123456
    "dispatch": true
  }
}
```

> Ticket belonging to guest

```json
{
  "ticket": {
    "guest_id": 98433
    "event_ticket_type_id": 123456
    "dispatch": true
  }
}
```

## Update a ticket

### Request

<div class="api-endpoint">
	<div class="endpoint-data">
		<i class="label label-patch">PATCH</i>
		<h6>/tickets/{id}</h6>
	</div>
</div>

#### Parameters

See parameters for create a ticket.

## Delete a ticket

### Request

<div class="api-endpoint">
	<div class="endpoint-data">
		<i class="label label-delete">DELETE</i>
		<h6>/tickets/{id}</h6>
	</div>
</div>

#### Parameters

None.
