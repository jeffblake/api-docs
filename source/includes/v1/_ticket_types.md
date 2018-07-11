# Ticket types

Ticket types are composed of two data models: ticket type, and event ticket type. A ticket type is a standalone entity that can be re-used for many different events.
An event ticket type associates a ticket type to a specific event.

## Ticket type properties

Attribute                      | Type     | Default   | Description
------------------------------ | -------- | --------- | -----------------
`name`                         | string   |           | Name of the ticket type.
`display_name`                 | string   |           | What is displayed to the guest, e.g. on the PDF. Defaults to the `name` if left blank.
`pdf_template_id`              | integer  |           | ID number of the associated PDF template.
`wallet_template_id`           | integer  |           | ID number of the associated Apple Wallet template.
`transferable`                 | boolean  | `true`    | Whether guests can transfer this ticket type to another guest.
`attachable`                   | boolean  | `true`    | Whether tickets are attached in emails (true) or provided as a download link (false).


## Event ticket type properties

Attribute                      | Type      | Description
------------------------------ | --------- | -----------
`ticket_type_id`               | integer   | ID of associated ticket type.
`event_id`                     | integer   | ID of associated event.
`starts_at`                    | datetime  | When this ticket is valid from. Display purposes only.
`ends_at`                      | datetime  | When this ticket is valid until. Display purposes only.
`pdf_template_id`              | integer   | Override the ticket type if necessary.
`wallet_template_id`           | integer   | Override the ticket type if necessary.


## Create a ticket type for an event

###  Request

<div class="api-endpoint">
	<div class="endpoint-data">
		<i class="label label-post">POST</i>
		<h6>/event_ticket_types</h6>
	</div>
</div>

#### Parameters
Parameter                                   | Type                 | Description
------------------------------------------- | -------------------- | -------------------------
`event_ticket_type`                         | `Event ticket type`  |  See properties above.
`event_ticket_type[ticket_type_attributes]` | `Ticket type`        |  See properties above. Used to create a new ticket type. Required if `event_ticket_type[ticket_type_id]` is not provided.

#### Examples

See example requests on the right.

> Create a ticket type and add it to an event

```json
{
  "event_ticket_type": {
    "event_id": 12345,
    "ticket_type_attributes": {
      "name": "GA"
    }
  }
}
```

> Add an existing ticket type to an event

```json
{
  "event_ticket_type": {
    "event_id": 12345,
    "ticket_type_id": 10001
  }
}
```