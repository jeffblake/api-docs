# Tickets

## Ticket properties

## Create a ticket

###  Request

<div class="api-endpoint">
	<div class="endpoint-data">
		<i class="label label-post">POST</i>
		<h6>/tickets</h6>
	</div>
</div>

#### Parameters
Parameter                          | Type        | Optional                                     | Description
---------------------------------- | ----------- | -------------------------------------------- | -------------------------
`ticket[name]`                     | `string`    | Yes                                          | Name to be shown on the ticket. Automatically set if `guest_id` is provided.
`ticket[email]`                    | `string`    | Yes                                          | Email address of the ticket owner. Automatically set if `guest_id` is provided.
`ticket[guest_id]`                 | `int`       | Yes                                          | Link a guest in your database as the owner of this ticket.
`ticket[event_ticket_type_id]`     | `int`       | No                                           | The Ticket Type to assign to the ticket.
`ticket[dispatch]`                 | `boolean`   | Yes                                          | If `true`, an email is dispatched to the owner of the ticket, with the ticket as a PDF attachment.
`ticket[barcode_id]`               | `string`    | Yes                                          | A barcode number will be automatically generated if one is not provided.
`ticket[list_id]`                  | `int`       | Yes                                          | The list to assign this ticket to.
`ticket[event_id]`                 | `int`       | Yes, if `event_ticket_type_id` is provided.  | The event to assign this ticket to.
`ticket[ticket_type_id]`           | `int`       | Yes, if `event_ticket_type_id` is provided.  | The ticket type to assign this ticket to.



> Standalone ticket

```json
{
  "ticket": {
    "name": "USD"
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