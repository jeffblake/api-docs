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

## Checkout states

`state`        | Enabled If      | Description
-------------- | -----------     | ----------------------------------
`email`        | Standard checkout mode.
`register`     | Standard checkout mode.
`order_form`   | Items in cart do not satisfy order form conditions.
`customize`    | A `master` variant was added to the cart, a specific variant needs to be chosen.
`addon`        | Any products in the order have addon relationships.
`tickets`      | Any ticket types in the order are set to collect name and/or email.
`password`     | Any event in the order is password protected.
`invite`       | An event in the order requires an invitation to proceed.
`member`       | Any ticket type in the order is set to collect a Member ID.
`membership`   | Any item in the order requires a membership to purchase.
`address`      | Billing or shipping address are required.
`delivery`     | Any item in the order requires shipping.
`form`         | Any event in the order has a form configured.
`reserved`     | Any item in the order is not currently onsale, but can be reserved.
`requested`    | Any item in the order is soldot, but can be requested (wait list).
`conflict`     | Any event in the order conflicts with another event in the order (if configured).
`payment`      | Order total is greater than 0.
`confirm`      | Setting to review order before placing is enabled.
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

<div class="api-endpoint">
	<div class="endpoint-data">
		<i class="label label-patch">PATCH</i>
		<h6>/checkout/{NUMBER}/resume</h6>
	</div>
</div>


## Begin checkout
Attempt to move the order to the next step in the checkout process without providing any new attributes. Typically this is used for moving an order from `cart` to the first step in the checkout process, as this transition does not require any new attributes.

<div class="api-endpoint">
	<div class="endpoint-data">
		<i class="label label-patch">PATCH</i>
		<h6>/checkout/{id}/next</h6>
	</div>
</div>

### Parameters
Parameter              | Description
---------------------- | -----------
`{id}`                 | Order ID.
`state`                | Optional. Attempt to move the order directly to this state.

### Response
Upon successful transition to checkout, Inspect the `state` (string) and `checkout_steps` (array of strings) attributes on the Order and update your UI accordingly.
The last step will be one of `complete`, `requested`, or `reserved`, depending on the availability and on-sale restrictions of the items in the cart.

## Update and transition order
This is the sole endpoint for transitioning an order through the various checkout steps. Which step the order is on will dictate which attributes need to be submitted.

<div class="api-endpoint">
	<div class="endpoint-data">
		<i class="label label-patch">PATCH</i>
		<h6>/checkout/{id}</h6>
	</div>
</div>

### Parameters
The following parameters should be submitted for every checkout step, along with the step-specific data.

Parameter              | Description
---------------------- | -----------
`{id}`                 | Order ID.
`order[guest_token]`   | Optional if your account is not enabled for multi-currency.
`order[state]`         | Provide the current `state` attribute that you are sending parameters for.
Step specific data.    | Include the relevent information specified below, according to the current step.

### Response Errors
Every time this endpoint is called, the order is first checked for checkout eligibility, so it is important to handle all of these errors in every checkout step.

Refer to the section on errors for the JSON format of the response.

Error `type`               | Meaning
-------------------------- | ----------------------------------
`checkout_not_allowed`     |
`order_processing`         |
`order_complete`           |
`invalid_state`            |



## `cart` step
The default state of all newly created orders.

## `tickets` step
The tickets step is included if the ticket type related to the line item in the cart has been set to include the name or email fields during checkout.
The purpose of this step is to collect attendee information prior to completion of an order.

The `tickets` attribute on the order will dictate which tickets need to be updated with names and/or emails.

When the `keep` attribute is `true`, a `name` is not required, because that ticket is being assigned to the `order.guest`.

> Example Request

```json
{
  "order": {
    "state": "tickets",
    "tickets": [
      {
        "id": 123456,
        "keep": true
      },
      {
        "id": 987655,
        "name": "Bizzy Bone"
      }
    ]
  }
}
```

> Example Response (Error)

```json

```

### Parameters
Parameter              | Description
---------------------- | -----------
`order[tickets]`       | Array. Include `id`, `name`, `email`, `keep`, for each ticket.

### Notes
* Only one ticket should be eligible to assign directly to the customer, the rest of the tickets should have a `name` attribute required, and optional `email`

## `address` step
This step is included if shipping is enabled for any of the line items, order total is greater than 0, and/or if the billing address is set to required for all orders (via the `CheckoutCustomization`), even if the order total is 0.

> Example Request

```json
{
  "order": {
    "state": "address",
    "bill_address": {
      "address1": "123 Main Street",
      "city": "Anytown",
      "zipcode": "92109",
      "state_id": 162,
      "country_id": 14
    },
    "ship_address": {
      "address1": "123 Main Street",
      "city": "Anytown",
      "zipcode": "92109",
      "state_code": "WA",
      "country_code": "AU"
    }
  }
}
```

`State` and `Country` information can either be provided from their respective `id` (fetched from the API), or as their ISO codes: `state_code` and `country_code`

Parameter              | Type     | Description
---------------------- | ------   | -----------
`order[bill_address]`  | `object` | See `Address` for format.
`order[ship_address]`  | `object` | See `Address` for format.

### Response
Upon successful addition of address information, you will see a populated `bill_address_id` and/or `ship_address_id`.

## `form` step
This step is included if a Form (i.e. Questions or Survey) has been configured on this order. Inspect the `form_responses` attribute.

Only the `answers` `id` and `value` need to be submitted back.
For multiple choice fields, the `answer.value` will be the `id` of the `FormFieldOption`

> Example Request

```json
{
	"order": {
		"state": "form",
		"responses": [
			{
				"id": 38133,
				"answers": [
				{
					"id": 167288,
					"value": "791"
				},
				{
					"id": 167286,
					"value": "592"
				},
				{
					"id": 167287,
					"value": "test"
				}
			]
			}

		]
	}
}
```

> Example Response (Error)

```json

```

Parameter                | Type     | Description
------------------------ | ------   | -----------
`order[form_responses]`  | `array`  | See `FormResponse` for format.

## `payment` step
This step is included if the order total is greater than 0. Inspect the `payment_methods` attribute to see which options are available for payment.

Do not submit credit card information via the API. Use your payment provider's Javascript SDK to create a token instead.

Parameter              | Type     | Description
---------------------- | ------   | -----------
`order[payments]`      | `array`  | See `Payment` for format.

## `processing` step
This step is not present in the `checkout_steps` attribute. Once payment information is submitted in the `payment` step, the payments are processed asynchronously during the `processing` state.

Poll the order until the `state` changes from `processing`. If payment failed, the `state` will return to `payment`. If successful, the order will be complete and in the `complete` state.

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