# Orders

See [**Objects**](#objects-order) section for details on the fields and relationships.

## Create an order
<aside class="notice">
Please note that once an order is created, the tickets are reserved for 15 minutes as indicated by the `expires_at` attribute. You can still send the guest to checkout after 15 minutes, and the system will attempt to re-reserve the tickets and continue checkout. If the tickets are no longer available, the user is unable to proceed.
</aside>

<div class="api-endpoint">
	<div class="endpoint-data">
		<i class="label label-post">POST</i>
		<h6>/orders</h6>
	</div>
</div>

### Request parameters

<aside class="success">
  When creating an order, you will receive back a property called `guest_token` (among others). You must retain this token, and use it to make any further updates
  to that order.
</aside>

> Create empty order

```shell
curl -X POST \
  https://app.guestmanager.com/api/public/v2/orders \
  -H 'Accept: application/json' \
  -H 'Authorization: Token abcdefg' \
  -H 'Content-Type: application/json' \
  -d '{
	"order": {
		"currency": "USD",
		"guest_checkout": true
	}
}'
```

> Empty order response

```json
{
    "id": 214890,
    "number": "GMH3P6G79VRKQJ",
    "currency": "USD",
    "state": "cart",
    "checkout_steps": [
        "address",
        "complete"
    ],
    "item_count": 0,
    "contact_id": null,
    "guest_token": "9b96188212222b3c1283bd3dc3ac9de0",
    "guest_checkout": true,
    "first_name": null,
    "last_name": null,
    "email": null,
    "phone_number": null,
    "phone_number_country": null,
    "completed_at": null,
    "expires_at": "2019-01-10T19:44:39.781909Z",
    "total": {
        "decimal": "0.0",
        "amount": 0,
        "formatted": "$0.00"
    },
    "item_total": {
        "decimal": "0.0",
        "amount": 0,
        "formatted": "$0.00"
    },
    "adjustment_total": {
        "decimal": "0.0",
        "amount": 0,
        "formatted": "$0.00"
    },
    "promo_total": {
        "decimal": "0.0",
        "amount": 0,
        "formatted": "$0.00"
    },
    "bill_address": null,
    "ship_address": null,
    "line_items": [],
    "adjustments": [],
    "promotions": [],
    "tickets": [],
    "payments": [],
    "responses": []
}
```


> Order with line items request

```shell
curl -X POST \
  https://app.guestmanager.com/api/public/v2/orders \
  -H 'Accept: application/json' \
  -H 'Authorization: Token abcdefg' \
  -H 'Content-Type: application/json' \
  -d '{
	"order": {
		"currency": "AUD",
		"guest_checkout": true,
		"first_name": "Jeff",
		"last_name": "Blake",
		"email": "jeff@gmail.com",
		"phone_number": "12068423456",
		"phone_number_country": "US",
		"line_items": [
			{
				"variant_id": 10542,
				"quantity": 2
			}
		]
	}
}'
```

> Order with line items response

```json
{
    "id": 214893,
    "number": "GMMAFBD17KIOGT",
    "currency": "AUD",
    "state": "cart",
    "checkout_steps": [
        "tickets",
        "address",
        "payment",
        "complete"
    ],
    "item_count": 2,
    "contact_id": 1390001,
    "guest_token": "487b26211c9f9d8584abfdbadedd42e5",
    "guest_checkout": true,
    "first_name": "Jeff",
    "last_name": "Blake",
    "email": "jeff@gmail.com",
    "phone_number": "+12068423456",
    "phone_number_country": "US",
    "completed_at": null,
    "expires_at": "2019-01-10T20:56:29.296919Z",
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
    "ship_address": null,
    "line_items": [
        {
            "id": 222986,
            "order_id": 214893,
            "name": "Sell tix",
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
            "id": 405427,
            "label": "Service Fee",
            "order_id": 214893,
            "adjustable_id": 222986,
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
            "id": 2596875,
            "number": "pucAP3KTv2d5TSurWhoE6GYb",
            "status": "pending",
            "name": null,
            "email": null,
            "barcode_id": "3146643903544781",
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
            "source_id": 222986,
            "links": {
                "pdf": null,
                "wallet": null
            }
        },
        {
            "id": 2596874,
            "number": "QHNLGkMVdQMH676q8kxtuNBL",
            "status": "pending",
            "name": null,
            "email": null,
            "barcode_id": "5127459989750870",
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
            "source_id": 222986,
            "links": {
                "pdf": null,
                "wallet": null
            }
        }
    ],
    "payments": [],
    "responses": []
}
```


Parameter                             | Type        | Required   | Default    | Description
--------------------------------      | ----------- | ---------- | ---------- | -----------
`transition_order`                    | `boolean`   | *no*       |            | Advance the order to the first checkout step.
`order[currency]`                     | `string`    | *yes*      |            | ISO code, e.g. `CAD`, `USD`, `AUD`, `GBP`
`order[email]`                        | `string`    | *no**      |            | Email of the purchaser.
`order[guest_checkout]`               | `boolean`   | *yes*      |            | Guest checkout mode must be enabled for all API orders.
`order[first_name]`                   | `string`    | *no**      |            | First name of purchaser.
`order[last_name]`                    | `string`    | *no**      |            | Last name of purchaser.
`order[phone_number]`                 | `string`    | *no*       |            | Phone number of purchaser. Number is validated accordingly to `phone_number_country`
`order[phone_number_country]`         | `string`    | *if `phone_number` provided*       |            | ISO country code of the phone number, e.g. `US`, `AU`, `CA`
`order[line_items]`                   | `array`     | *no**       |            | Array of line items. Each line item must contain `variant_id`, and `quantity`



* `*` Not initially required, but will be required in order to complete the checkout process.


### Response

#### Error

#### Validation errors

`code`                | Meaning
--------------------- | ------------------------
`not_available`       | Product is no longer on sale. Could be disabled, or past the `end_sale_at` date.
`sold_out`            | Product is sold out.

## Fetch order


<div class="api-endpoint">
	<div class="endpoint-data">
		<i class="label label-get">GET</i>
		<h6>/orders/{id}</h6>
	</div>
</div>

> Fetch order request

```shell
curl -X GET \
  https://app.guestmanager.com/api/public/v2/orders/214894 \
  -H 'Accept: application/json' \
  -H 'Authorization: Token abcdefg' \
  -H 'Content-Type: application/json' \
  -d '{
	"guest_token": "752b3a667b53068433edc796848c1345"
}'
```

Parameter                             | Type        | Required   | Default    | Description
--------------------------------      | ----------- | ---------- | ---------- | -----------
`guest_token`                         | `string`    | *yes*      |            | Provide the `guest_token` given to you in the create order endpoint.
`fields`                              | `string`    | *no*       |            | Request a subset of the order attributes if desired.
`include`                             | `string`    | *no*       |            | Request specific relationships.

## Update order
Updates an order. If updating existing `line_items`, you must provide the `id` of each line item, as shown in the example at the right.

<div class="api-endpoint">
	<div class="endpoint-data">
		<i class="label label-patch">PATCH</i>
		<h6>/orders/{id}</h6>
	</div>
</div>

> Update line item quantity

```shell
curl -X PATCH \
  https://app.guestmanager.com/api/public/v2/orders/214894 \
  -H 'Accept: application/json' \
  -H 'Authorization: Token abcdefg' \
  -H 'Content-Type: application/json' \
  -d '{
	"guest_token": "752b3a667b53068433edc796848c1345",
	"order": {
		"line_items": [
			{
				"id": 222987,
				"quantity": 1
			}
		]
	}
}'
```

> Update line item response

```json
{
    "id": 214894,
    "number": "GMBIU2EZ7K9D46",
    "currency": "AUD",
    "state": "cart",
    "checkout_steps": [
        "tickets",
        "address",
        "form",
        "payment",
        "complete"
    ],
    "item_count": 1,
    "contact_id": 1390001,
    "guest_token": "752b3a667b53068433edc796848c1345",
    "guest_checkout": true,
    "first_name": "Jeff",
    "last_name": "Blake",
    "email": "jeff@gmail.com",
    "phone_number": "+12068423456",
    "phone_number_country": "US",
    "completed_at": null,
    "expires_at": "2019-01-10T20:59:20.537628Z",
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
    "ship_address": null,
    "line_items": [
        {
            "id": 222987,
            "order_id": 214894,
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
            "id": 405428,
            "label": "Service Fee",
            "order_id": 214894,
            "adjustable_id": 222987,
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
    "promotions": [],
    "tickets": [
        {
            "id": 2596876,
            "number": "V7DGKDb4BRZMc5tpcCsawJGx",
            "status": "pending",
            "name": null,
            "email": null,
            "barcode_id": "4818716329830908",
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
            "source_id": 222987,
            "links": {
                "pdf": null,
                "wallet": null
            }
        }
    ],
    "payments": [],
    "responses": [
        {
            "id": 52690,
            "form_id": 3587
        }
    ]
}
```

### Request parameters
See create order endpoint for complete list of request parameters.

Parameter              | Required     | Description
---------------------- | -----------  | ------------
`guest_token`          | *yes*        | Provide the order's guest_token to authorize updates to this order.



### Response

####  Errors
Exceptions vary in format. Please see the right hand panel for examples.

`type`                      | Meaning
--------------------------- | -------------------------------
`cannot_modify`             | Order is in an uneditable state. (e.g. `complete`)
`guest_checkout_required`   | Orders created through the API must be in `guest_checkout` mode.

## Apply coupon code
Attempts to apply a coupon/promo code to the order.

<div class="api-endpoint">
	<div class="endpoint-data">
		<i class="label label-patch">PATCH</i>
		<h6>/orders/{id}/apply_coupon_code</h6>
	</div>
</div>

> Apply coupon code request

```shell
curl -X PATCH \
  https://app.guestmanager.com/api/public/v2/orders/214894/apply_coupon_code \
  -H 'Accept: application/json' \
  -H 'Authorization: Token abcdefg' \
  -H 'Content-Type: application/json' \
  -d '{
	"guest_token": "752b3a667b53068433edc796848c1345",
	"coupon_code": "20off"
}'
```

> Apply coupon code response

```json
{
    "id": 214895,
    "number": "GMIZAJD7EKOQUX",
    "currency": "AUD",
    "state": "cart",
    "checkout_steps": [
        "tickets",
        "address",
        "form",
        "payment",
        "complete"
    ],
    "item_count": 2,
    "contact_id": 1390001,
    "guest_token": "af73d05bd847d66b62c21e56661c7069",
    "guest_checkout": true,
    "first_name": "Jeff",
    "last_name": "Blake",
    "email": "jeff@gmail.com",
    "phone_number": "+12068423456",
    "phone_number_country": "US",
    "completed_at": null,
    "expires_at": "2019-01-10T23:08:28.081445Z",
    "total": {
        "decimal": "26.72",
        "amount": 2672,
        "formatted": "$26.72"
    },
    "item_total": {
        "decimal": "30.0",
        "amount": 3000,
        "formatted": "$30.00"
    },
    "adjustment_total": {
        "decimal": "-3.28",
        "amount": -328,
        "formatted": "$-3.28"
    },
    "promo_total": {
        "decimal": "-6.0",
        "amount": -600,
        "formatted": "$-6.00"
    },
    "bill_address": null,
    "ship_address": null,
    "line_items": [
        {
            "id": 222988,
            "order_id": 214895,
            "name": "Sell tix",
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
            "id": 405431,
            "label": "Promotion",
            "order_id": 214895,
            "adjustable_id": 222988,
            "adjustable_type": "LineItem",
            "source_id": 329,
            "source_type": "PromotionAction",
            "included": false,
            "mandatory": true,
            "eligible": true,
            "groupable": true,
            "finalized": false,
            "amount": {
                "decimal": "-6.0",
                "amount": -600,
                "formatted": "$-6.00"
            }
        },
        {
            "id": 405430,
            "label": "Service Fee",
            "order_id": 214895,
            "adjustable_id": 222988,
            "adjustable_type": "LineItem",
            "source_id": 4946,
            "source_type": "ServiceFeeRate",
            "included": false,
            "mandatory": true,
            "eligible": true,
            "groupable": true,
            "finalized": false,
            "amount": {
                "decimal": "2.72",
                "amount": 272,
                "formatted": "$2.72"
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
            "id": 2596879,
            "number": "DRHTvauq8N3Ay7ERFh7TUsmW",
            "status": "pending",
            "name": null,
            "email": null,
            "barcode_id": "2395309216989206",
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
            "source_id": 222988,
            "links": {
                "pdf": null,
                "wallet": null
            }
        },
        {
            "id": 2596878,
            "number": "nKUcCduXxmXN9DoYtsDnJqt4",
            "status": "pending",
            "name": null,
            "email": null,
            "barcode_id": "2208377212609034",
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
            "source_id": 222988,
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
            "form_id": 3587
        }
    ]
}
```

> Sample error response (Status `422`)

```json
{
    "type": "validation_error",
    "message": "Coupon code already applied to order",
    "model": "Order",
    "id": 214894,
    "errors": {
        "attributes": [
            {
                "attribute": "coupon_code",
                "label": "Coupon code",
                "code": "already_applied",
                "message": "already applied to order",
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
```

### Request parameters
Parameter              | Type     | Required     | Description
---------------------- | -------- | ------------ | --------------
`coupon_code`          | `string` | *yes*        | Optional if your account is not enabled for multi-currency.
`guest_token`          | `string` | *yes*        | Provide the order's guest_token to authorize updates to this order.

### Response
Status         | Description
-------------- | --------------
`200`          | Coupon successfully applied. Inspect the new `total`, `promo_total`, `adjustment_total`, `promotions`, and `adjustments` on the Order for details.
`422`          | Error. Coupon not found, expired, inactive, or ineligible. Review the `error` message.

## List orders

<div class="api-endpoint">
	<div class="endpoint-data">
		<i class="label label-get">GET</i>
		<h6>/orders</h6>
	</div>
</div>

## Add items
“Add to cart” Adds specified quantity of the variant to the order. This is an additive operation, i.e., if the order already contains 1 of the `variant_id`,
and you add 2 more, the relevant `line_item` `quantity` will be updated to `3`.

This is a convenience endpoint as you do not need to submit the correct `line_item_id` parameter.

<div class="api-endpoint">
	<div class="endpoint-data">
		<i class="label label-get">POST</i>
		<h6>/orders/{order-id}/line_items/add</h6>
	</div>
</div>

> Add variant to order

```shell
curl -X POST \
  https://app.guestmanager.com/api/public/v2/orders/214895/line_items/add \
  -H 'Accept: application/json' \
  -H 'Authorization: Token abcdefg' \
  -H 'Content-Type: application/json' \
  -d '{
	"guest_token": "af73d05bd847d66b62c21e56661c7069",
	"variant_id": 10542,
	"quantity": 1
}'
```

> Response

```json
{
    "id": 214895,
    "number": "GMIZAJD7EKOQUX",
    "currency": "AUD",
    "state": "cart",
    "checkout_steps": [
        "tickets",
        "address",
        "form",
        "payment",
        "complete"
    ],
    "item_count": 3,
    "contact_id": 1390001,
    "guest_token": "af73d05bd847d66b62c21e56661c7069",
    "guest_checkout": true,
    "first_name": "Jeff",
    "last_name": "Blake",
    "email": "jeff@gmail.com",
    "phone_number": "+12068423456",
    "phone_number_country": "US",
    "completed_at": null,
    "expires_at": "2019-01-10T23:08:28.081445Z",
    "total": {
        "decimal": "40.08",
        "amount": 4008,
        "formatted": "$40.08"
    },
    "item_total": {
        "decimal": "45.0",
        "amount": 4500,
        "formatted": "$45.00"
    },
    "adjustment_total": {
        "decimal": "-4.92",
        "amount": -492,
        "formatted": "$-4.92"
    },
    "promo_total": {
        "decimal": "-9.0",
        "amount": -900,
        "formatted": "$-9.00"
    },
    "bill_address": null,
    "ship_address": null,
    "line_items": [
        {
            "id": 222988,
            "order_id": 214895,
            "name": "Sell tix",
            "description": null,
            "variant_id": 10542,
            "quantity": 3,
            "currency": "AUD",
            "bundle_item_id": null,
            "price": {
                "decimal": "15.0",
                "amount": 1500,
                "formatted": "$15.00"
            },
            "subtotal": {
                "decimal": "45.0",
                "amount": 4500,
                "formatted": "$45.00"
            }
        }
    ],
    "adjustments": [
        {
            "id": 405431,
            "label": "Promotion",
            "order_id": 214895,
            "adjustable_id": 222988,
            "adjustable_type": "LineItem",
            "source_id": 329,
            "source_type": "PromotionAction",
            "included": false,
            "mandatory": true,
            "eligible": true,
            "groupable": true,
            "finalized": false,
            "amount": {
                "decimal": "-9.0",
                "amount": -900,
                "formatted": "$-9.00"
            }
        },
        {
            "id": 405430,
            "label": "Service Fee",
            "order_id": 214895,
            "adjustable_id": 222988,
            "adjustable_type": "LineItem",
            "source_id": 4946,
            "source_type": "ServiceFeeRate",
            "included": false,
            "mandatory": true,
            "eligible": true,
            "groupable": true,
            "finalized": false,
            "amount": {
                "decimal": "4.08",
                "amount": 408,
                "formatted": "$4.08"
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
            "id": 2596880,
            "number": "sbAG83hpEeZNNXGxGChh8MCF",
            "status": "pending",
            "name": null,
            "email": null,
            "barcode_id": "6756402339979732",
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
            "source_id": 222988,
            "links": {
                "pdf": null,
                "wallet": null
            }
        },
        {
            "id": 2596879,
            "number": "DRHTvauq8N3Ay7ERFh7TUsmW",
            "status": "pending",
            "name": null,
            "email": null,
            "barcode_id": "2395309216989206",
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
            "source_id": 222988,
            "links": {
                "pdf": null,
                "wallet": null
            }
        },
        {
            "id": 2596878,
            "number": "nKUcCduXxmXN9DoYtsDnJqt4",
            "status": "pending",
            "name": null,
            "email": null,
            "barcode_id": "2208377212609034",
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
            "source_id": 222988,
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
            "form_id": 3587
        }
    ]
}
```

### Request parameters
Parameter              | Type      | Description
---------------------- | --------  | -------------
`variant_id`           | `integer` | The variant to add to the order.
`quantity`             | `integer` | Quantity of `variant_id` to add.


## Remove items
“Remove from cart” Removes specified quantity of the variant from the order.

This is a convenience endpoint as you do not need to submit the correct `line_item_id` parameter.

<div class="api-endpoint">
	<div class="endpoint-data">
		<i class="label label-get">POST</i>
		<h6>/orders/{order-id}/line_items/remove</h6>
	</div>
</div>

> Remove item request

```shell
curl -X POST \
  https://app.guestmanager.com/api/public/v2/orders/214895/line_items/remove \
  -H 'Accept: application/json' \
  -H 'Authorization: Token abcdefg' \
  -H 'Content-Type: application/json' \
  -d '{
	"guest_token": "af73d05bd847d66b62c21e56661c7069",
	"variant_id": 10542,
	"quantity": 2
}'
```

> Remove item response

```json
{
    "id": 214895,
    "number": "GMIZAJD7EKOQUX",
    "currency": "AUD",
    "state": "cart",
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
    "expires_at": "2019-01-10T23:08:28.081445Z",
    "total": {
        "decimal": "13.36",
        "amount": 1336,
        "formatted": "$13.36"
    },
    "item_total": {
        "decimal": "15.0",
        "amount": 1500,
        "formatted": "$15.00"
    },
    "adjustment_total": {
        "decimal": "-1.64",
        "amount": -164,
        "formatted": "$-1.64"
    },
    "promo_total": {
        "decimal": "-3.0",
        "amount": -300,
        "formatted": "$-3.00"
    },
    "bill_address": null,
    "ship_address": null,
    "line_items": [
        {
            "id": 222988,
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
            "id": 405431,
            "label": "Promotion",
            "order_id": 214895,
            "adjustable_id": 222988,
            "adjustable_type": "LineItem",
            "source_id": 329,
            "source_type": "PromotionAction",
            "included": false,
            "mandatory": true,
            "eligible": true,
            "groupable": true,
            "finalized": false,
            "amount": {
                "decimal": "-3.0",
                "amount": -300,
                "formatted": "$-3.00"
            }
        },
        {
            "id": 405430,
            "label": "Service Fee",
            "order_id": 214895,
            "adjustable_id": 222988,
            "adjustable_type": "LineItem",
            "source_id": 4946,
            "source_type": "ServiceFeeRate",
            "included": false,
            "mandatory": true,
            "eligible": true,
            "groupable": true,
            "finalized": false,
            "amount": {
                "decimal": "1.36",
                "amount": 136,
                "formatted": "$1.36"
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
            "id": 2596878,
            "number": "nKUcCduXxmXN9DoYtsDnJqt4",
            "status": "pending",
            "name": null,
            "email": null,
            "barcode_id": "2208377212609034",
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
            "source_id": 222988,
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
            "form_id": 3587
        }
    ]
}
```

> Attempting to remove too many items (response)

```json
{
    "type": "validation_error",
    "message": "Quantity Quantity must be greater than zero",
    "model": "LineItem",
    "id": 222988,
    "errors": {
        "attributes": [
            {
                "attribute": "quantity",
                "label": "Quantity",
                "code": "greater_than",
                "message": "Quantity must be greater than zero",
                "detail": {
                    "value": -3,
                    "count": -1
                }
            }
        ],
        "associations": {}
    }
}
```

### Request parameters
Parameter              | Type      | Description
---------------------- | --------  | -------------
`variant_id`           | `integer` | The variant to remove from the order.
`quantity`             | `integer` | Quantity of `variant_id` to remove.

## Delete line item
Deletes an entire line item from the order.

<div class="api-endpoint">
	<div class="endpoint-data">
		<i class="label label-delete">DELETE</i>
		<h6>/orders/{order-id}/line_items/{id}</h6>
	</div>
</div>

> Delete line item request

```shell
curl -X DELETE \
  https://app.guestmanager.com/api/public/v2/orders/214895/line_items/222988 \
  -H 'Accept: application/json' \
  -H 'Authorization: Token abcdefg' \
  -H 'Content-Type: application/json' \
  -d '{
	"guest_token": "af73d05bd847d66b62c21e56661c7069"
}'
```

> Delete line item response

```json
{
    "id": 214895,
    "number": "GMIZAJD7EKOQUX",
    "currency": "AUD",
    "state": "cart",
    "checkout_steps": [
        "address",
        "complete"
    ],
    "item_count": 0,
    "contact_id": 1390001,
    "guest_token": "af73d05bd847d66b62c21e56661c7069",
    "guest_checkout": true,
    "first_name": "Jeff",
    "last_name": "Blake",
    "email": "jeff@gmail.com",
    "phone_number": "+12068423456",
    "phone_number_country": "US",
    "completed_at": null,
    "expires_at": "2019-01-10T23:08:28.081445Z",
    "total": {
        "decimal": "0.0",
        "amount": 0,
        "formatted": "$0.00"
    },
    "item_total": {
        "decimal": "0.0",
        "amount": 0,
        "formatted": "$0.00"
    },
    "adjustment_total": {
        "decimal": "0.0",
        "amount": 0,
        "formatted": "$0.00"
    },
    "promo_total": {
        "decimal": "0.0",
        "amount": 0,
        "formatted": "$0.00"
    },
    "bill_address": null,
    "ship_address": null,
    "line_items": [],
    "adjustments": [],
    "promotions": [
        {
            "id": 9185,
            "promotion_id": 301,
            "code": null
        }
    ],
    "tickets": [],
    "payments": [],
    "responses": [
        {
            "id": 52691,
            "form_id": 3587
        }
    ]
}
```

### Parameters
Parameter        | Type      | Description
---------------- | --------  | -------------
`{id}`           | `integer` | The line item ID to delete. *not* the variant ID.

## Update line item

Updates a line item to a specified quantity.

<div class="api-endpoint">
	<div class="endpoint-data">
		<i class="label label-patch">PATCH</i>
		<h6>/orders/{order-id}/line_items/{id}</h6>
	</div>
</div>

> Update line item request

```shell
curl -X PATCH \
  https://app.guestmanager.com/api/public/v2/orders/214895/line_items/222989 \
  -H 'Accept: application/json' \
  -H 'Authorization: Token abcdefg' \
  -H 'Content-Type: application/json' \
  -d '{
	"guest_token": "af73d05bd847d66b62c21e56661c7069",
	"line_item": {
		"quantity": 1
	}
}'
```

> Update line item response

```json
{
    "id": 214895,
    "number": "GMIZAJD7EKOQUX",
    "currency": "AUD",
    "state": "cart",
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
    "expires_at": "2019-01-10T23:08:28.081445Z",
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
    "ship_address": null,
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
            "form_id": 3587
        }
    ]
}
```

### Request parameters

Parameter                   | Type      | Description
--------------------------- | --------  | -------------
`{id}`                      | `integer` | The line item ID to delete. *not* the variant ID.
`line_item[quantity]`       | `integer` | The quantity.


