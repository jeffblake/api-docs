# Orders


## Order properties

> Example Response

```json
{
    "id": 176260,
    "number": "GM720XKYDP5SLR",
    "state": "cart",
    "checkout_steps": [
        "email",
        "register",
        "tickets",
        "address",
        "form",
        "complete"
    ],
    "guest_id": null,
    "guest_checkout": false,
    "first_name": "Jeff",
    "last_name": "Blake",
    "email": "jeff.blake2@gmail.com",
    "phone_number": "+61491570156",
    "phone_number_country": "AU",
    "item_count": 1,
    "total": "0.0",
    "item_total": "0.0",
    "adjustment_total": "0.0",
    "promo_total": "0.0",
    "currency": "AUD",
    "completed_at": null,
    "expires_at": "2017-10-25T17:54:51.557604Z",
    "links": {
        "cart": "http://miele.guestmanager.dev:3000/cart?guest_token=5b8fa186f25a225fbe95744baf6326fb&id=GM720XKYDP5SLR",
        "checkout": "http://miele.guestmanager.dev:3000/cart/checkout/GM720XKYDP5SLR?guest_token=5b8fa186f25a225fbe95744baf6326fb"
    },
    "payment_methods": [
        {
            "id": 78,
            "type": "Gateway::Stripe",
            "name": "Stripe",
            "description": null,
            "display_name": "Credit Card",
            "currencies": [
                "AUD"
            ],
            "billing_address_required": true,
            "payment_profiles_enabled": true,
            "test_mode": false,
            "active": true,
            "tokenize_key": "pk_live_*****"
        }
    ],
    "line_items": [
        {
            "id": 176643,
            "order_id": 176260,
            "name": "Free",
            "description": null,
            "variant_id": 6522,
            "quantity": 1,
            "price": "0.0",
            "amount": "0.0",
            "currency": "AUD",
            "bundle_item_id": null,
            "ticket_tier": {
                "name": "Complimentary Owner Product Demonstrations",
                "event": {
                    "name": "Oven",
                    "date": "04-11-2017",
                    "time": "10:30am-12:00pm",
                    "venue": "Knoxfield"
                }
            }
        }
    ],
    "adjustments": [],
    "promotions": [],
    "tickets": []
}

```


Attribute                      | Type     | Description
------------------------------ | -------- | -----------
`number`                       | string   | Order number. <i class="label label-info">read-only</i>
`state`                        | string   | The current step of the order. See order states. <i class="label label-info">read-only</i>
`checkout_steps`               | array    | List of all states dynamically computed for this order. Can change from state to state. <i class="label label-info">read-only</i>
`guest_id`                     | integer  | The guest associated to this order. <i class="label label-info">read-only</i>
`guest_token`                  | string   | Unique token for the session. <i class="label label-info">read-only</i>
`payment_state`                | string   | Current payment status. See payment states. <i class="label label-info">read-only</i>
`currency`                     | string   | ISO code of currency. All items added to order must have a price available in this currency.
`item_count`                   | integer  | Number of items in the order. Sum of all `line_item.quantity` <i class="label label-info">read-only</i>
`total`                        | decimal  | Grand (net) total, after adjustments, promotions, fees, and taxes. <i class="label label-info">read-only</i>
`item_total`                   | decimal  | Sum of all `line_item.price x line_item.quantity` <i class="label label-info">read-only</i>
`adjustment_total`             | decimal  | Sum of all non-line-item charges (promotions, taxes, fees, etc). <i class="label label-info">read-only</i>
`payment_total`                | decimal  | Sum of all completed payments. <i class="label label-info">read-only</i>
`additional_tax_total`         | decimal  | Additional taxes passed onto the guest. <i class="label label-info">read-only</i>
`included_tax_total`           | decimal  | Included taxes. <i class="label label-info">read-only</i>
`included_service_fee_total`   | decimal  | Included fees. <i class="label label-info">read-only</i>
`additional_service_fee_total` | decimal  | Extra fees passed onto the guest. <i class="label label-info">read-only</i>
`promo_total`                  | decimal  | The discount on this order. <i class="label label-info">read-only</i>
`shipment_total`               | decimal  | Total shipping charges. <i class="label label-info">read-only</i>
`taxable_adjustment_total`     | decimal  |
`non_taxable_adjustment_total` | decimal  |
`application_fee_total`        | decimal  | The fee charged by Guest Manager. <i class="label label-info">read-only</i>
`merchant_fee_total`           | decimal  | The portion of service fees collected that are denoted as merchant fees. <i class="label label-info">read-only</i>
`expires_at`                   | datetime | When the items are released back into inventory. Default 15 minutes.
`completed_at`                 | datetime | When the order was completed. <i class="label label-info">read-only</i>
`abandon_at`                   | datetime | When the order will be marked as abandoned. Configured via `CheckoutCustomization` <i class="label label-info">read-only</i>
`can_checkout_at`              | datetime | If the order is `reserved`, the time at which the order will be eligible for completion. <i class="label label-info">read-only</i>
`created_by_id`                | integer  | The admin who created this order. <i class="label label-info">read-only</i>
`canceler_id`                  | integer  | The admin who canceled this order. <i class="label label-info">read-only</i>
`approver_id`                  | integer  | The admin who approved this order. <i class="label label-info">read-only</i>
`holder_id`                    | integer  | The admin who held this order. <i class="label label-info">read-only</i>
`company_id`                   | integer  | The company associated to this order. <i class="label label-info">read-only</i>
`checkout_customization_id`    | integer  | The checkout configuration. <i class="label label-info">read-only</i>
`zone_id`                      | integer  | Tax zone. <i class="label label-info">read-only</i>
`order_form_id`                | integer  | Related order form.
`order_channel_id`             | integer  | Related order channel for tracking purposes.
`shipping_method_id`           | integer  | Chosen shipping method.
`bill_address_id`              | integer  | Billing address.
`ship_address_id`              | integer  | Shipping address.
`shipment_state`               | string   | Status of shipment.
`email_state`                  | string   |
`metadata`                     | hash     | Extra data stored in order.
`mobile`                       | boolean  | If the order was placed on a mobile device.
`locked`                       | boolean  | If the order is locked for updates.
`last_ip_address`              | string   | Last known ip address of guest.
`message`                      | text     | Admin note.

## Related objects

Attribute                    | Type    | Description
---------------------------- | ------- | -----------
`bill_address`               | object  | Billing address.
`ship_address`               | object  | Shipping address.
`line_items`                 | array   | Items in the order.
`payment_methods`            | array   | Available payment methods.
`tickets`                    | array   | Tickets relevant to the line items.
`responses`                  | array   | Surveys/questions.
`payments`                   | array   | Payments made on this order.


## Guest checkout properties
Add these attributes through either the create or update order endpoint.
The `guest_id` attribute will be set on the order through a find or create process based on the provided email and phone number.

Attribute                    | Type    | Description
---------------------------- | ------- | -----------
`guest_checkout`             | boolean | Set this to `true` to enable guest checkout.
`first_name`                 | string  | First name of guest.
`last_name`                  | string  | Last name of guest.
`email`                      | string  | Email address of guest. Format is validated.
`phone_number`               | string  | Phone number of guest. <br>Format is validated according to the `phone_number_country` provided.
`phone_number_country`       | string  | Country of the phone number. 2 digit ISO code, uppercase.

## Order states

`state`        | Description
-------------- | -----------
`cart`         | Default state for all newly created orders.
`expired`      | Order was not completed within 15 minutes of creation. Can be resumed.
`voided`       | Voided by an admin. Cannot be resumed.
`canceled`     | Canceled by admin or guest. Cannot be resumed.
`abandoned`    | No action was taken on order X hours after expired. Enabled if Abandoned Cart Recovery feature is configured.

## Payment states

`payment_state`    | Description
------------------ | ---------------
`paid`             | `payment_total == total`
`balance_due`      | `payment_total < total`
`credit_owed`      | `payment_total > total`
`partial_refund`   | Some items have been refunded.
`refunded`         | All items have been refunded.
`failed`           | Payment failed.

## Exceptional errors
Exceptions vary in format. Please see the right hand panel for examples.

`type`            | Meaning
----------------- | -------------------------------
`cannot_modify`   | Order is in an uneditable state. (e.g. `complete`)

## Create an order
<aside class="notice">
Please note that once an order is created, the tickets are reserved for 15 minutes as indicated by the `expires_at` attribute. You can still send the guest to checkout after 15 minutes, and the system will attempt to re-reserve the tickets and continue checkout. If the tickets are no longer available, the user is unable to proceed.
</aside>
###  Request

<div class="api-endpoint">
	<div class="endpoint-data">
		<i class="label label-post">POST</i>
		<h6>/orders</h6>
	</div>
</div>

#### Parameters
Parameter              | Description
---------------------- | -----------
`order[currency]`      | Optional if your account is not enabled for multi-currency.
`order[line_items]`    |

> Empty order

```json
{
  "order": {
    "currency": "USD"
  }
}
```


> Order w/ line items

```json
{
  "order": {
    "currency": "USD",
    "guest_checkout": true,
    "first_name": "Jeff",
    "last_name": "Blake",
    "email": "jeff@guestmanager.com",
    "phone_number": "2069405178",
    "phone_number_country": "US",
    "line_items": [
      {
        "variant_id": 12345,
        "quantity": 2
      }
    ]
  }
}
```

## Retrieve an order


<div class="api-endpoint">
	<div class="endpoint-data">
		<i class="label label-get">GET</i>
		<h6>/orders/{id}</h6>
	</div>
</div>

## Update an order
Updates an order. All line items must be provided.

<div class="api-endpoint">
	<div class="endpoint-data">
		<i class="label label-patch">PATCH</i>
		<h6>/orders/{id}</h6>
	</div>
</div>

> Example Request

```json
{
  "order": {
    "line_items": [
      {
        "variant_id": 12345,
        "quantity": 4
      }
    ]
  }
}
```

## Apply coupon code
Attempts to apply a coupon/promo code to the order.

<div class="api-endpoint">
	<div class="endpoint-data">
		<i class="label label-patch">PATCH</i>
		<h6>/orders/{id}/apply_coupon_code</h6>
	</div>
</div>

### Parameters
Parameter              | Type     | Description
---------------------- | -------- | -------------
`coupon_code`          | `string` | Optional if your account is not enabled for multi-currency.

### Response
Status         | Description
-------------- | --------------
`200`          | Coupon successfully applied. Inspect the new `total`, `promo_total`, and `adjustment_total`
`422`          | Error. Coupon not found, expired, inactive, or ineligible. Review the `error` message.

## List orders

<div class="api-endpoint">
	<div class="endpoint-data">
		<i class="label label-get">GET</i>
		<h6>/orders</h6>
	</div>
</div>

## Add items
“Add to cart” Adds specified quantity of the variant to the order.

<div class="api-endpoint">
	<div class="endpoint-data">
		<i class="label label-get">POST</i>
		<h6>/orders/{id}/line_items/add</h6>
	</div>
</div>

### Parameters
Parameter              | Type      | Description
---------------------- | --------  | -------------
`variant_id`           | `integer` | The variant to add to the order.
`quantity`             | `integer` | Quantity of `variant_id` to add.


## Remove items
“Remove from cart” Removes specified quantity of the variant from the order.

<div class="api-endpoint">
	<div class="endpoint-data">
		<i class="label label-get">POST</i>
		<h6>/orders/{id}/line_items/remove</h6>
	</div>
</div>

### Parameters
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

### Parameters
Parameter        | Type      | Description
---------------- | --------  | -------------
`{order-id}`     | integer   | Order ID.
`{id}`           | `integer` | The line item ID to delete. *not* the variant ID.

## Update line item

<div class="api-endpoint">
	<div class="endpoint-data">
		<i class="label label-patch">PATCH</i>
		<h6>/orders/{order-id}/line_items/{id}</h6>
	</div>
</div>

### Parameters
Parameter                   | Type      | Description
--------------------------- | --------  | -------------
`{order-id}`                | integer   | Order ID.
`{id}`                      | `integer` | The line item ID to delete. *not* the variant ID.
`line_item[quantity]`       | `integer` | The quantity.


