# Checkout
There are two ways to implement the checkout process via the API.

## Link based checkout
The `links` attribute on the `Order` will specify a URL that you can redirect users to or open in an `iFrame` popup within your site. This will utilize the Guest Manager UI.

> Order

```json
{
  "links": {
    "cart": "...",
    "checkout": "..."
  }
}
```

## API based checkout
For complete control of the checkout experience, you may implement the checkout step UI yourself and make API calls to transition the order forward.

It is highly recommended to thoroughly handle all possible errors, and to log any response code in the `4xx` range for further review to ensure you are providing
a good experience for your customers.

## Checkout states

`state`        | Description
-------------- | ----------------------------------
`order_form`   | Items in cart do not satisfy order form conditions.
`email`        | Standard checkout mode. You will not see this step in the API.
`register`     | Standard checkout mode. You will not see this step in the API.
`tickets`      | Any ticket types in the order are set to collect name and/or email.
`address`      | Billing or shipping address are required.
`delivery`     | Any item in the order requires shipping.
`form`         | Any event in the order has a form configured.
`reserved`     | Any item in the order is not currently onsale, but can be reserved.
`requested`    | Any item in the order is soldot, but can be requested (wait list).
`payment`      | Order total is greater than 0.
`processing`   | Payment is currently processing in the background.
`complete`     | All previous states have been satisfied.

## Standard checkout
Requires the guest to login or register. This method is not currently supported via the API.

## Guest checkout
Allows the guest to checkout an order without authenticating or registering their email or phone number.
The `enable_guest_checkout` option must be enabled on the `CheckoutCustomization` object.
The order will require `email`, `first_name`, and `last_name` to be updated before transitioning the order from the `cart` step to the checkout process. `phone_number` and `phone_number_country` may also be provided.

## Resuming an order
Inspect the `expires_at` attribute on the order. This is 15 minutes in the future by default. When this timer expires, the order is moved from whatever state it is currently, to `expired`. The tickets are released back to inventory
When an order expires, need to resume it. Need to check that inventory was successfully re-reserved (e.g. if sold out, not on sale, tickets are not available).
Whenever you make an API call to update an order (add, remove items, transition checkout steps), if the order is `expired`, the system will attempt to automatically resume it before processing your request. Therefore,
it is important that you are properly handling the response status code for every API call, as you could suddenly experience an error where the tickets are no longer available.

You can also manually resume an order if it is expired. This is the endpoint:

<div class="api-endpoint">
	<div class="endpoint-data">
		<i class="label label-patch">PATCH</i>
		<h6>/checkout/{id}/resume</h6>
	</div>
</div>

> Resume order

```shell
curl -X PATCH \
  https://app.guestmanager.com/api/public/v2/checkout/214895/resume \
  -H 'Accept: application/json' \
  -H 'Authorization: Token abcdefg' \
  -H 'Content-Type: application/json' \
  -d '{
	"guest_token": "af73d05bd847d66b62c21e56661c7069"
}'
```

> Resume order successful

```json
{
  "id": 214895,
  "state": "cart", // previous successful state
  ... omitted ...
}
```

> Resume order error

```json
{
    "type": "validation_error",
    "message": "State cannot transition via \"resume\"",
    "model": "Order",
    "id": 214895,
    "errors": {
        "attributes": [
            {
                "attribute": "state",
                "label": "State",
                "code": "invalid_transition",
                "message": "cannot transition via \"resume\"",
                "detail": {
                    "event": "resume",
                    "state": "cart"
                }
            }
        ],
        "associations": {
            "tickets": {},
            "form_responses": {},
            "line_items": {}
        }
    }
}
```

### Request parameters

Parameter              | Description
---------------------- | -----------
`guest_token`          | Provide the order's guest_token to authorize updates to this order.

## Begin checkout
Attempt to move the order to the next step in the checkout process without providing any new attributes. Typically this is used for moving an order from `cart` to the first step in the checkout process, as this transition does not require any new attributes.

<div class="api-endpoint">
	<div class="endpoint-data">
		<i class="label label-patch">PATCH</i>
		<h6>/checkout/{id}/next</h6>
	</div>
</div>

> Transition order to next state

```shell
curl -X PATCH \
  https://app.guestmanager.com/api/public/v2/checkout/214895/next \
  -H 'Accept: application/json' \
  -H 'Authorization: Token abcdefg' \
  -H 'Content-Type: application/json' \
  -d '{
	"guest_token": "af73d05bd847d66b62c21e56661c7069"
}'
```

> Transition order success

```json
{
    "id": 214895,
    "number": "GMIZAJD7EKOQUX",
    "currency": "AUD",
    "state": "tickets",
    "checkout_steps": [
        "tickets",
        "address",
        "form",
        "payment",
        "complete"
    ],
    "item_count": 1,
    "contact_id": 1390001,
    "guest_token": "af73d05bd847d66b62c21e56661c7069",
    "guest_checkout": true,
    "first_name": "Jeff",
    "last_name": "Blake",
    "email": "jeff@gmail.com",
    "phone_number": "+12068423456",
    "phone_number_country": "US",
    "completed_at": null,
    "expires_at": "2019-01-10T23:35:39.074446Z",
    "total": {
        "decimal": "16.45",
        "amount": 1645,
        "formatted": "$16.45"
    },
    "item_total": {
        "decimal": "15.0",
        "amount": 1500,
        "formatted": "$15.00"
    },
    "adjustment_total": {
        "decimal": "1.45",
        "amount": 145,
        "formatted": "$1.45"
    },
    "promo_total": {
        "decimal": "0.0",
        "amount": 0,
        "formatted": "$0.00"
    },
    "bill_address": null,
    "line_items": [
        {
            "id": 222989,
            "order_id": 214895,
            "name": "Sell tix",
            "description": null,
            "variant_id": 10542,
            "quantity": 1,
            "currency": "AUD",
            "bundle_item_id": null,
            "price": {
                "decimal": "15.0",
                "amount": 1500,
                "formatted": "$15.00"
            },
            "subtotal": {
                "decimal": "15.0",
                "amount": 1500,
                "formatted": "$15.00"
            }
        }
    ],
    "adjustments": [
        {
            "id": 405432,
            "label": "Service Fee",
            "order_id": 214895,
            "adjustable_id": 222989,
            "adjustable_type": "LineItem",
            "source_id": 4946,
            "source_type": "ServiceFeeRate",
            "included": false,
            "mandatory": true,
            "eligible": true,
            "groupable": true,
            "finalized": false,
            "amount": {
                "decimal": "1.45",
                "amount": 145,
                "formatted": "$1.45"
            }
        }
    ],
    "promotions": [
        {
            "id": 9185,
            "promotion_id": 301,
            "code": null
        }
    ],
    "tickets": [
        {
            "id": 2596882,
            "number": "cYV9WBPdCA71C2f6zw86GTK6",
            "status": "pending",
            "name": null,
            "email": null,
            "barcode_id": "2035349948646978",
            "note": null,
            "event_id": 71615,
            "ticket_type_id": 2470,
            "event_ticket_type_id": 19503,
            "list_id": 1017266,
            "contact_id": 1390001,
            "dispatched_at": null,
            "downloaded_at": null,
            "checkin_at": null,
            "source_type": "line_item",
            "source_id": 222989,
            "links": {
                "pdf": null,
                "wallet": null
            }
        },
        {
            "id": 2596881,
            "number": "gSH3Q7K1atT1EsEcVpUWTATr",
            "status": "pending",
            "name": null,
            "email": null,
            "barcode_id": "8393038480612290",
            "note": null,
            "event_id": 71615,
            "ticket_type_id": 2470,
            "event_ticket_type_id": 19503,
            "list_id": 1017266,
            "contact_id": 1390001,
            "dispatched_at": null,
            "downloaded_at": null,
            "checkin_at": null,
            "source_type": "line_item",
            "source_id": 222989,
            "links": {
                "pdf": null,
                "wallet": null
            }
        }
    ],
    "payments": [],
    "responses": [
        {
            "id": 52691,
            "form_id": 3587,
            "answers": [
                {
                    "id": 231811,
                    "form_field_id": 10773,
                    "value": null,
                    "human_value": null,
                    "field": {
                        "id": 10773,
                        "label": "Other",
                        "required": false,
                        "enabled": true,
                        "help_text": "",
                        "position": 3,
                        "type": "text_field",
                        "options": []
                    }
                },
                {
                    "id": 231810,
                    "form_field_id": 10646,
                    "value": null,
                    "human_value": null,
                    "field": {
                        "id": 10646,
                        "label": "Which Miele appliance do you own?",
                        "required": true,
                        "enabled": true,
                        "help_text": "",
                        "position": 2,
                        "type": "multiple_choice",
                        "options": [
                            {
                                "id": 498,
                                "form_field_id": 10646,
                                "name": "DGD 4635 Steam oven with pressure",
                                "value": "",
                                "type": null,
                                "position": 0
                            },
                            {
                                "id": 784,
                                "form_field_id": 10646,
                                "name": "Other (list below)",
                                "value": "",
                                "type": null,
                                "position": 99
                            }
                        ]
                    }
                },
                {
                    "id": 231809,
                    "form_field_id": 10647,
                    "value": null,
                    "human_value": null,
                    "field": {
                        "id": 10647,
                        "label": "When did you buy your appliance?",
                        "required": true,
                        "enabled": true,
                        "help_text": "",
                        "position": 1,
                        "type": "text_field",
                        "options": []
                    }
                },
                {
                    "id": 231808,
                    "form_field_id": 10658,
                    "value": null,
                    "human_value": null,
                    "field": {
                        "id": 10658,
                        "label": "How did you find out about the demonstration?",
                        "required": true,
                        "enabled": true,
                        "help_text": "",
                        "position": 0,
                        "type": "multiple_choice",
                        "options": [
                            {
                                "id": 893,
                                "form_field_id": 10658,
                                "name": "Referred by a Retailer",
                                "value": "",
                                "type": null,
                                "position": 0
                            },
                            {
                                "id": 783,
                                "form_field_id": 10658,
                                "name": "Friend Referral",
                                "value": "",
                                "type": null,
                                "position": 7
                            }
                        ]
                    }
                }
            ]
        }
    ]
}
```

### Request parameters
Parameter              | Description
---------------------- | -----------
`guest_token`          | Provide the order's guest_token to authorize updates to this order.
`state`                | Optional. Attempt to move the order directly to this state.

### Response
Upon successful transition to checkout, Inspect the `state` (string) and `checkout_steps` (array of strings) attributes on the Order and update your UI accordingly.
The last step will be one of `complete`, `requested`, or `reserved`, depending on the availability and on-sale restrictions of the items in the cart.

## Update and transition order
This is the sole endpoint for transitioning an order through the various checkout steps. Which step the order is on will dictate which attributes need to be submitted.

<div class="api-endpoint">
	<div class="endpoint-data">
		<i class="label label-patch">PATCH</i>
		<h6>/checkout/{order-id}</h6>
	</div>
</div>

> See `step` for relevant example

```shell
curl -X PATCH \
  https://app.guestmanager.com/api/public/v2/checkout/214895/ \
  -H 'Accept: application/json' \
  -H 'Authorization: Token abcdefg' \
  -H 'Content-Type: application/json' \
  -d '{
	"guest_token": "af73d05bd847d66b62c21e56661c7069",
	"order": {
		"state": "tickets",
		... step specific data ...
	}
}'
```

### Request parameters
The following parameters should be submitted for every checkout step, along with the step-specific data.

Parameter              | Required      | Description
---------------------- | ------------- | -----------
`guest_token`          | *yes*         | Provide the order's guest_token to authorize updates to this order.
`order[state]`         | *yes*         | Provide the current `state` attribute that you are sending parameters for.
Step specific data.    | *if required* | Include the relevant information specified below, according to the current step.

### Response errors

> `invalid_state` response `400 - Bad Request`

```json
{
    "type": "invalid_state",
    "message": "valid order states (tickets, address, form, payment, complete) does not include notastate",
    "error": true
}
```

> Timer expired, items no longer available (`sold_out`)

```json
{
    "type": "checkout_not_allowed",
    "message": "General Admission missing inventory.",
    "error": true,
    "detail": {
        "type": "validation_error",
        "message": "General Admission missing inventory.",
        "model": "Order",
        "id": 214895,
        "errors": {
            "attributes": [
                {
                    "attribute": "base",
                    "label": "Base",
                    "code": "invalid_inventory",
                    "message": "General Admission missing inventory.",
                    "detail": {}
                }
            ],
            "associations": {
                "tickets": {},
                "form_responses": {},
                "line_items": {}
            }
        }
    }
}
```

Every time this endpoint is called, the order is first checked for checkout eligibility, so it is important to handle all of these errors in every checkout step.

Refer to the section on errors for the JSON format of the response.

Error `type`               | Response code  | Meaning
-------------------------- | -------------- | ----------------------------------
`checkout_not_allowed`     | `400`          | A variety of checks are performed to ensure an order may be checked out. See table below for definitions and sample error responses.
`invalid_state`            | `400`          | Order cannot transition to provided state, or the submitted `state` is not valid. Inspect `checkout_steps`


#### `checkout_not_allowed` explanations
Before we process your API call, we validate the order to ensure it is in a valid state. If it is not, you will receive response code `400 - Bad Request`,
with a json body containing a `type` attribute equal to `checkout_not_allowed`. The `errors` attribute will provide reasoning as to why.

The reasons are structured as `validation_error` objects under the `errors` key.

* Order exceeded checkout timer, and an attempt to re-reserve the inventory failed. This is represented as a `sold_out` `code`
* One or more of the `variants` in the order are no longer on sale (could be disabled, `on_sale_at` changed, etc)
* Order is in an un-modifiable state (`complete`, `canceled`, `processing`, `voided`, `requested`, `reserved`, etc)
* Order has no `line_items`

## `cart` step
The default state of all newly created orders. `cart` is not a `checkout_step`.

## `tickets` step

> Checkout `tickets` step request

```shell
curl -X PATCH \
  https://app.guestmanager.com/api/public/v2/checkout/214896 \
  -H 'Accept: application/json' \
  -H 'Authorization: Token abcdefg' \
  -H 'Content-Type: application/json' \
  -d '{
	"guest_token": "5f0826c680f4eeb1d82522eda57c82c3",
	"order": {
		"state": "tickets",
		"tickets": [
			{
				"id": 2596884,
				"keep": true
			},
			{
				"id": 2596883,
				"name": "Bizzy Bone"
			}
		]
	}
}'
```

> Response `200`

```json
{
    "id": 214896,
    "number": "GMCDNR5AFLE3SG",
    "currency": "AUD",
    "state": "address",
    "checkout_steps": [
        "tickets",
        "address",
        "form",
        "payment",
        "complete"
    ],
    "item_count": 2,
    "contact_id": 1390001,
    "guest_token": "5f0826c680f4eeb1d82522eda57c82c3",
    "guest_checkout": true,
    "first_name": "Jeff",
    "last_name": "Blake",
    "email": "jeff@gmail.com",
    "phone_number": "+12068423456",
    "phone_number_country": "US",
    "completed_at": null,
    "expires_at": "2019-01-11T02:33:05.770844Z",
    "total": {
        "decimal": "32.9",
        "amount": 3290,
        "formatted": "$32.90"
    },
    "item_total": {
        "decimal": "30.0",
        "amount": 3000,
        "formatted": "$30.00"
    },
    "adjustment_total": {
        "decimal": "2.9",
        "amount": 290,
        "formatted": "$2.90"
    },
    "promo_total": {
        "decimal": "0.0",
        "amount": 0,
        "formatted": "$0.00"
    },
    "bill_address": null,
    "line_items": [
        {
            "id": 222990,
            "order_id": 214896,
            "name": "General Admission",
            "description": null,
            "variant_id": 10542,
            "quantity": 2,
            "currency": "AUD",
            "bundle_item_id": null,
            "price": {
                "decimal": "15.0",
                "amount": 1500,
                "formatted": "$15.00"
            },
            "subtotal": {
                "decimal": "30.0",
                "amount": 3000,
                "formatted": "$30.00"
            }
        }
    ],
    "adjustments": [
        {
            "id": 405433,
            "label": "Service Fee",
            "order_id": 214896,
            "adjustable_id": 222990,
            "adjustable_type": "LineItem",
            "source_id": 4946,
            "source_type": "ServiceFeeRate",
            "included": false,
            "mandatory": true,
            "eligible": true,
            "groupable": true,
            "finalized": false,
            "amount": {
                "decimal": "2.9",
                "amount": 290,
                "formatted": "$2.90"
            }
        }
    ],
    "promotions": [],
    "tickets": [
        {
            "id": 2596884,
            "number": "uFN3Ea5PzzjAGfcUWTgXxZrD",
            "status": "pending",
            "name": "Jeff Blake",
            "email": null,
            "barcode_id": "4315850278275881",
            "note": null,
            "event_id": 71615,
            "ticket_type_id": 2470,
            "event_ticket_type_id": 19503,
            "list_id": 1017266,
            "contact_id": 1390001,
            "dispatched_at": null,
            "downloaded_at": null,
            "checkin_at": null,
            "source_type": "line_item",
            "source_id": 222990,
            "links": {
                "pdf": null,
                "wallet": null
            }
        },
        {
            "id": 2596883,
            "number": "7TubHcKJU6fzL98ez6wPusLK",
            "status": "pending",
            "name": "Bizzy Bone",
            "email": null,
            "barcode_id": "4161426812156383",
            "note": null,
            "event_id": 71615,
            "ticket_type_id": 2470,
            "event_ticket_type_id": 19503,
            "list_id": 1017266,
            "contact_id": 1390001,
            "dispatched_at": null,
            "downloaded_at": null,
            "checkin_at": null,
            "source_type": "line_item",
            "source_id": 222990,
            "links": {
                "pdf": null,
                "wallet": null
            }
        }
    ],
    "payments": [],
    "responses": [
        {
            "id": 52692,
            "form_id": 3587,
            "answers": [
                {
                    "id": 231815,
                    "form_field_id": 10773,
                    "value": null,
                    "human_value": null,
                    "field": {
                        "id": 10773,
                        "label": "Other",
                        "required": false,
                        "enabled": true,
                        "help_text": "",
                        "position": 3,
                        "type": "text_field",
                        "options": []
                    }
                },
                {
                    "id": 231814,
                    "form_field_id": 10646,
                    "value": null,
                    "human_value": null,
                    "field": {
                        "id": 10646,
                        "label": "Which Miele appliance do you own?",
                        "required": true,
                        "enabled": true,
                        "help_text": "",
                        "position": 2,
                        "type": "multiple_choice",
                        "options": [
                            {
                                "id": 498,
                                "form_field_id": 10646,
                                "name": "DGD 4635 Steam oven with pressure",
                                "value": "",
                                "type": null,
                                "position": 0
                            }
                        ]
                    }
                },
                {
                    "id": 231813,
                    "form_field_id": 10647,
                    "value": null,
                    "human_value": null,
                    "field": {
                        "id": 10647,
                        "label": "When did you buy your appliance?",
                        "required": true,
                        "enabled": true,
                        "help_text": "",
                        "position": 1,
                        "type": "text_field",
                        "options": []
                    }
                },
                {
                    "id": 231812,
                    "form_field_id": 10658,
                    "value": null,
                    "human_value": null,
                    "field": {
                        "id": 10658,
                        "label": "How did you find out about the demonstration?",
                        "required": true,
                        "enabled": true,
                        "help_text": "",
                        "position": 0,
                        "type": "multiple_choice",
                        "options": [
                            {
                                "id": 783,
                                "form_field_id": 10658,
                                "name": "Friend Referral",
                                "value": "",
                                "type": null,
                                "position": 7
                            }
                        ]
                    }
                }
            ]
        }
    ]
}
```

The tickets step is included if the ticket type related to the line item in the cart has been set to include the name or email fields during checkout.
The purpose of this step is to collect attendee information prior to completion of an order.

The `tickets` array on the order will dictate which tickets need to be updated with names and/or emails. You must provide the `id` of each ticket in the array.

When the `keep` attribute is `true`, a `name` is not required, because that ticket is being assigned to the `order.contact`.

> `422 - Unprocessable Entity` response

```json
{
    "type": "validation_error",
    "message": "Cannot transition state via :next from :tickets (Reason(s): Transition halted)",
    "model": "Order",
    "id": 214896,
    "errors": {
        "attributes": [],
        "associations": {
            "tickets": {
                "2596883": {
                    "type": "validation_error",
                    "message": "Name can't be blank",
                    "model": "Ticket",
                    "id": 2596883,
                    "errors": {
                        "attributes": [
                            {
                                "attribute": "name",
                                "label": "Name",
                                "name": null,
                                "code": "blank",
                                "message": "can't be blank",
                                "detail": {}
                            }
                        ],
                        "associations": {}
                    }
                }
            },
            "form_responses": {},
            "line_items": {}
        }
    }
}
```

### Request parameters
Parameter              | Description
---------------------- | -----------
`order[tickets]`       | Array. Include `id`, `name`, `email`, `keep`, for each ticket.

### Notes
* Only one ticket should be eligible to assign directly to the customer, the rest of the tickets should have a `name` attribute required, and optional `email`

## `address` step

> Checkout `address` step request

```shell
curl -X PATCH \
  https://app.guestmanager.com/api/public/v2/checkout/214896 \
  -H 'Accept: application/json' \
  -H 'Authorization: Token abcdefg' \
  -H 'Content-Type: application/json' \
  -d '{
    "guest_token": "5f0826c680f4eeb1d82522eda57c82c3",
    "order": {
        "state": "address",
        "bill_address": {
            "address1": "123 Main Street",
            "city": "Anytown",
            "zipcode": "92109",
            "state_code": "WA",
            "country_code": "US"
        }
    }
}'
```

> `200` response

```json
{
    "id": 214896,
    "number": "GMCDNR5AFLE3SG",
    "currency": "AUD",
    "state": "form",
    "checkout_steps": [
        "tickets",
        "address",
        "form",
        "payment",
        "complete"
    ],
    "item_count": 2,
    "contact_id": 1390001,
    "guest_token": "5f0826c680f4eeb1d82522eda57c82c3",
    "guest_checkout": true,
    "first_name": "Jeff",
    "last_name": "Blake",
    "email": "jeff@gmail.com",
    "phone_number": "+12068423456",
    "phone_number_country": "US",
    "completed_at": null,
    "expires_at": "2019-01-11T02:33:05.770844Z",
    "total": {
        "decimal": "32.9",
        "amount": 3290,
        "formatted": "$32.90"
    },
    "item_total": {
        "decimal": "30.0",
        "amount": 3000,
        "formatted": "$30.00"
    },
    "adjustment_total": {
        "decimal": "2.9",
        "amount": 290,
        "formatted": "$2.90"
    },
    "promo_total": {
        "decimal": "0.0",
        "amount": 0,
        "formatted": "$0.00"
    },
    "bill_address": {
        "id": 144812,
        "address1": "123 Main Street",
        "city": "Anytown",
        "zipcode": "92109",
        "state_name": "Washington",
        "state_code": "WA",
        "country_name": "United States",
        "country_code": "US"
    },
    "line_items": [
        {
            "id": 222990,
            "order_id": 214896,
            "name": "General Admission",
            "description": null,
            "variant_id": 10542,
            "quantity": 2,
            "currency": "AUD",
            "bundle_item_id": null,
            "price": {
                "decimal": "15.0",
                "amount": 1500,
                "formatted": "$15.00"
            },
            "subtotal": {
                "decimal": "30.0",
                "amount": 3000,
                "formatted": "$30.00"
            }
        }
    ],
    "adjustments": [
        {
            "id": 405433,
            "label": "Service Fee",
            "order_id": 214896,
            "adjustable_id": 222990,
            "adjustable_type": "LineItem",
            "source_id": 4946,
            "source_type": "ServiceFeeRate",
            "included": false,
            "mandatory": true,
            "eligible": true,
            "groupable": true,
            "finalized": false,
            "amount": {
                "decimal": "2.9",
                "amount": 290,
                "formatted": "$2.90"
            }
        }
    ],
    "promotions": [],
    "tickets": [
        {
            "id": 2596883,
            "number": "7TubHcKJU6fzL98ez6wPusLK",
            "status": "pending",
            "name": "Bizzy Bone",
            "email": null,
            "barcode_id": "4161426812156383",
            "note": null,
            "event_id": 71615,
            "ticket_type_id": 2470,
            "event_ticket_type_id": 19503,
            "list_id": 1017266,
            "contact_id": 1390001,
            "dispatched_at": null,
            "downloaded_at": null,
            "checkin_at": null,
            "source_type": "line_item",
            "source_id": 222990,
            "links": {
                "pdf": null,
                "wallet": null
            }
        },
        {
            "id": 2596884,
            "number": "uFN3Ea5PzzjAGfcUWTgXxZrD",
            "status": "pending",
            "name": "Jeff Blake",
            "email": null,
            "barcode_id": "4315850278275881",
            "note": null,
            "event_id": 71615,
            "ticket_type_id": 2470,
            "event_ticket_type_id": 19503,
            "list_id": 1017266,
            "contact_id": 1390001,
            "dispatched_at": null,
            "downloaded_at": null,
            "checkin_at": null,
            "source_type": "line_item",
            "source_id": 222990,
            "links": {
                "pdf": null,
                "wallet": null
            }
        }
    ],
    "payments": [],
    "responses": [
        {
            "id": 52692,
            "form_id": 3587,
            "answers": [
                {
                    "id": 231815,
                    "form_field_id": 10773,
                    "value": null,
                    "human_value": null,
                    "field": {
                        "id": 10773,
                        "label": "Other",
                        "required": false,
                        "enabled": true,
                        "help_text": "",
                        "position": 3,
                        "type": "text_field",
                        "options": []
                    }
                },
                {
                    "id": 231814,
                    "form_field_id": 10646,
                    "value": null,
                    "human_value": null,
                    "field": {
                        "id": 10646,
                        "label": "Which Miele appliance do you own?",
                        "required": true,
                        "enabled": true,
                        "help_text": "",
                        "position": 2,
                        "type": "multiple_choice",
                        "options": [
                            {
                                "id": 498,
                                "form_field_id": 10646,
                                "name": "DGD 4635 Steam oven with pressure",
                                "value": "",
                                "type": null,
                                "position": 0
                            }
                        ]
                    }
                },
                {
                    "id": 231813,
                    "form_field_id": 10647,
                    "value": null,
                    "human_value": null,
                    "field": {
                        "id": 10647,
                        "label": "When did you buy your appliance?",
                        "required": true,
                        "enabled": true,
                        "help_text": "",
                        "position": 1,
                        "type": "text_field",
                        "options": []
                    }
                },
                {
                    "id": 231812,
                    "form_field_id": 10658,
                    "value": null,
                    "human_value": null,
                    "field": {
                        "id": 10658,
                        "label": "How did you find out about the demonstration?",
                        "required": true,
                        "enabled": true,
                        "help_text": "",
                        "position": 0,
                        "type": "multiple_choice",
                        "options": [
                            {
                                "id": 893,
                                "form_field_id": 10658,
                                "name": "Referred by a Retailer",
                                "value": "",
                                "type": null,
                                "position": 0
                            }
                        ]
                    }
                }
            ]
        }
    ]
}
```

This step is included if shipping is enabled for any of the line items, order total is greater than 0, and/or if the billing address is set to required for all orders (via the `CheckoutCustomization`), even if the order total is 0.


`State` and `Country` information can either be provided from their respective `id` (fetched from the API), or as their ISO codes: `state_code` and `country_code`

Parameter              | Type     | Required                     | Description
---------------------- | ------   | ---------------------------- | -----------
`order[bill_address]`  | `object` | *yes*                        | See `Address` for format.
`order[ship_address]`  | `object` | *if `delivery` step present  | See `Address` for format.

### Response
Upon successful addition of address information, you will see a populated `bill_address_id` and/or `ship_address_id`, and corresponding
`bill_address` and `ship_address` relationships on the order.

## `form` step

> Checkout `form` step request

```shell
curl -X PATCH \
  https://app.guestmanager.com/api/public/v2/checkout/214896 \
  -H 'Accept: application/json' \
  -H 'Authorization: Token abcdefg' \
  -H 'Content-Type: application/json' \
  -d '{
    "guest_token": "5f0826c680f4eeb1d82522eda57c82c3",
    "order": {
        "state": "form",
        "responses": [
            {
                "id": 52692,
                "answers": [
                    {
                        "id": 231815,
                        "value": "text field answer"
                    },
                    {
                        "id": 231814,
                        "value": 784 /* multiple choice `field_id` */
                    },
                    {
                        "id": 231813,
                        "value": "January"
                    },
                    {
                        "id": 231812,
                        "value": 580 /* multiple choice `field_id` */
                    }
                ]
            }
        ]
    }
}'
```

> `200` response

```json
{
    "id": 214896,
    "number": "GMCDNR5AFLE3SG",
    "currency": "AUD",
    "state": "payment",
    "checkout_steps": [
        "tickets",
        "address",
        "form",
        "payment",
        "complete"
    ],
    "item_count": 2,
    "contact_id": 1390001,
    "guest_token": "5f0826c680f4eeb1d82522eda57c82c3",
    "guest_checkout": true,
    "first_name": "Jeff",
    "last_name": "Blake",
    "email": "jeff@gmail.com",
    "phone_number": "+12068423456",
    "phone_number_country": "US",
    "completed_at": null,
    "expires_at": "2019-01-11T02:49:39.185424Z",
    "total": {
        "decimal": "32.9",
        "amount": 3290,
        "formatted": "$32.90"
    },
    "item_total": {
        "decimal": "30.0",
        "amount": 3000,
        "formatted": "$30.00"
    },
    "adjustment_total": {
        "decimal": "2.9",
        "amount": 290,
        "formatted": "$2.90"
    },
    "promo_total": {
        "decimal": "0.0",
        "amount": 0,
        "formatted": "$0.00"
    },
    "bill_address": {
        "id": 144813,
        "address1": "123 Main Street",
        "city": "Anytown",
        "zipcode": "92109",
        "state_name": null,
        "state_code": null,
        "country_name": "United States",
        "country_code": "US"
    },
    "line_items": [
        {
            "id": 222990,
            "order_id": 214896,
            "name": "General Admission",
            "description": null,
            "variant_id": 10542,
            "quantity": 2,
            "currency": "AUD",
            "bundle_item_id": null,
            "price": {
                "decimal": "15.0",
                "amount": 1500,
                "formatted": "$15.00"
            },
            "subtotal": {
                "decimal": "30.0",
                "amount": 3000,
                "formatted": "$30.00"
            }
        }
    ],
    "adjustments": [
        {
            "id": 405433,
            "label": "Service Fee",
            "order_id": 214896,
            "adjustable_id": 222990,
            "adjustable_type": "LineItem",
            "source_id": 4946,
            "source_type": "ServiceFeeRate",
            "included": false,
            "mandatory": true,
            "eligible": true,
            "groupable": true,
            "finalized": false,
            "amount": {
                "decimal": "2.9",
                "amount": 290,
                "formatted": "$2.90"
            }
        }
    ],
    "promotions": [],
    "tickets": [
        {
            "id": 2596883,
            "number": "7TubHcKJU6fzL98ez6wPusLK",
            "status": "pending",
            "name": "Bizzy Bone",
            "email": null,
            "barcode_id": "4161426812156383",
            "note": null,
            "event_id": 71615,
            "ticket_type_id": 2470,
            "event_ticket_type_id": 19503,
            "list_id": 1017266,
            "contact_id": 1390001,
            "dispatched_at": null,
            "downloaded_at": null,
            "checkin_at": null,
            "source_type": "line_item",
            "source_id": 222990,
            "links": {
                "pdf": null,
                "wallet": null
            }
        },
        {
            "id": 2596884,
            "number": "uFN3Ea5PzzjAGfcUWTgXxZrD",
            "status": "pending",
            "name": "Jeff Blake",
            "email": null,
            "barcode_id": "4315850278275881",
            "note": null,
            "event_id": 71615,
            "ticket_type_id": 2470,
            "event_ticket_type_id": 19503,
            "list_id": 1017266,
            "contact_id": 1390001,
            "dispatched_at": null,
            "downloaded_at": null,
            "checkin_at": null,
            "source_type": "line_item",
            "source_id": 222990,
            "links": {
                "pdf": null,
                "wallet": null
            }
        }
    ],
    "payments": [],
    "responses": [
        {
            "id": 52692,
            "form_id": 3587,
            "answers": [
                {
                    "id": 231815,
                    "form_field_id": 10773,
                    "value": "text field answer",
                    "human_value": "text field answer",
                    "field": {
                        "id": 10773,
                        "label": "Other",
                        "required": false,
                        "enabled": true,
                        "help_text": "",
                        "position": 3,
                        "type": "text_field",
                        "options": []
                    }
                },
                {
                    "id": 231814,
                    "form_field_id": 10646,
                    "value": "784",
                    "human_value": "Other (list below)",
                    "field": {
                        "id": 10646,
                        "label": "Which Miele appliance do you own?",
                        "required": true,
                        "enabled": true,
                        "help_text": "",
                        "position": 2,
                        "type": "multiple_choice",
                        "options": [
                            {
                                "id": 498,
                                "form_field_id": 10646,
                                "name": "DGD 4635 Steam oven with pressure",
                                "value": "",
                                "type": null,
                                "position": 0
                            }
                        ]
                    }
                },
                {
                    "id": 231813,
                    "form_field_id": 10647,
                    "value": "January",
                    "human_value": "January",
                    "field": {
                        "id": 10647,
                        "label": "When did you buy your appliance?",
                        "required": true,
                        "enabled": true,
                        "help_text": "",
                        "position": 1,
                        "type": "text_field",
                        "options": []
                    }
                },
                {
                    "id": 231812,
                    "form_field_id": 10658,
                    "value": "580",
                    "human_value": "Miele Experience Website",
                    "field": {
                        "id": 10658,
                        "label": "How did you find out about the demonstration?",
                        "required": true,
                        "enabled": true,
                        "help_text": "",
                        "position": 0,
                        "type": "multiple_choice",
                        "options": [
                            {
                                "id": 893,
                                "form_field_id": 10658,
                                "name": "Referred by a Retailer",
                                "value": "",
                                "type": null,
                                "position": 0
                            }
                        ]
                    }
                }
            ]
        }
    ]
}
```

> Example Response (Error)

```json

```

This step is included if a Form (i.e. Questions or Survey) has been configured on this order. Inspect the `responses` attribute on the `Order`.

Only the `answers` `id` and `value` need to be submitted back.
For multiple choice fields, the `answer.value` will be the `id` of the `FormFieldOption`

Parameter                | Type     | Description
------------------------ | ------   | -----------
`order[responses]`       | `array`  | See `Response` object for format.

## `payment` step
This step is included if the order total is greater than 0. Inspect the `payment_methods` attribute to see which options are available for payment.

Do not submit credit card information via the API. Use your payment provider's Javascript SDK to create a token instead.

Parameter              | Type     | Description
---------------------- | ------   | -----------
`order[payments]`      | `array`  | See `Payment` for format.

> Example Request

```json
{
	"order": {
		"state": "payment",
		"payments": [{
				"payment_method_id": 75,
				"source": {
					"brand": "visa",
					"last_four": "4680",
					"token": "tok_1231231231312322",
					"cvv": "123"
				}
			}

		]
	}
}
```

### Payment request parameters

Parameter                 | Type     | Description
------------------------- | ------   | -----------
`amount`                  | decimal  | Leave this blank and it will be automatically be set to the amount due on the order.
`payment_method_id`       | integer  | The payment method ID.
`source.last_four`        | string   | Last 4 digits on the credit card.
`source.brand`            | string   | Credit card type. One of `visa`, `master`, `american_express`, `jcb`, `diners_club`, or `discover`
`source.token`            | string   | The tokenized identifier of the credit card, created using the payment method SDK.
`source.cardholder_name`  | string   | Name of the card owner.
`source.cvv`              | `string` | 3 or 4 digit code on the card to perform verification.

## `processing` step
This step is not present in the `checkout_steps` attribute. Once payment information is submitted in the `payment` step, the payments are processed asynchronously during the `processing` state.

Poll the order until the `state` changes from `processing`. If payment failed, the `state` will return to `payment`. If successful, the order will be complete and in the `complete` state.

### Poll order state
If the order is still processing, a single `state` attribute will be returned, for efficiency. If the order is no longer processing, you will receive a full `Order` object back.

<div class="api-endpoint">
	<div class="endpoint-data">
		<i class="label label-get">GET</i>
		<h6>/orders/{id}/poll?guest_token=xyz</h6>
	</div>
</div>

> Example Response (Payment Processing)

```json
{
  "state": "processing"
}
```

> Example Response (Order Complete)

```json
{
  "id": 1232323
  "state": "complete",
  "payment_state": "paid"
  /* attributes redacted */
}
```

## `complete` step
Order is now complete. Tickets have been fulfilled. The order is not necessarily fully paid at this point. `completed_at` will be non-null.

Attribute              | Value
---------------------- | ------
`state`                | `complete`
`completed_at`         | `iso8601 datetime`
`payment_state`        | `paid|balance_due|credit_owed`

## `requested` step
Included if any of the products in the order are currently sold out, *and* the product has `can_request` attribute enabled.

## `reserved` step
Included if any of the products in the order are not currently on sale, *and* the product has `can_reserve` attribute enabled.