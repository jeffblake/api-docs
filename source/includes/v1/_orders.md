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
Parameter              | Description
---------------------- | -----------
`order[currency]`      | Optional if your account is not enabled for multi-currency.
`order[line_items]`    |
`transition_order`     | Include this parameter to automatically being the checkout process.

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

## Update order
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
        /* no ID present, creates new line item */
        "variant_id": 12345,
        "quantity": 4
      },
      {
        /* updates existing line item */
        "id": 12345,
        "variant_id": 9999,
        "quantity": 2
      }
    ]
  }
}
```

### Request parameters
Parameter              | Description
---------------------- | -----------
`{id}`                 | Order ID.
`guest_token`          | Provide the order's guest_token to authorize updates to this order.
`transition_order`     | Include this parameter to automatically being the checkout process.

### Response

####  Errors
Exceptions vary in format. Please see the right hand panel for examples.

`type`            | Meaning
----------------- | -------------------------------
`cannot_modify`   | Order is in an uneditable state. (e.g. `complete`)

## Apply coupon code
Attempts to apply a coupon/promo code to the order.

<div class="api-endpoint">
	<div class="endpoint-data">
		<i class="label label-patch">PATCH</i>
		<h6>/orders/{id}/apply_coupon_code</h6>
	</div>
</div>

### Request parameters
Parameter              | Type     | Description
---------------------- | -------- | -------------
`coupon_code`          | `string` | Optional if your account is not enabled for multi-currency.
`guest_token`          | `string` | Provide the order's guest_token to authorize updates to this order.

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
		<h6>/orders/{order-id}/line_items/add</h6>
	</div>
</div>

### Request parameters
Parameter              | Type      | Description
---------------------- | --------  | -------------
`variant_id`           | `integer` | The variant to add to the order.
`quantity`             | `integer` | Quantity of `variant_id` to add.


## Remove items
“Remove from cart” Removes specified quantity of the variant from the order.

<div class="api-endpoint">
	<div class="endpoint-data">
		<i class="label label-get">POST</i>
		<h6>/orders/{order-id}/line_items/remove</h6>
	</div>
</div>

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

### Request parameters

Parameter                   | Type      | Description
--------------------------- | --------  | -------------
`{order-id}`                | integer   | Order ID.
`{id}`                      | `integer` | The line item ID to delete. *not* the variant ID.
`line_item[quantity]`       | `integer` | The quantity.


