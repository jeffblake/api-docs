# Errors

## Status Codes

Error Code | Meaning
---------- | -------
`400` | Bad Request
`401` | Unauthorized -- Your API key is wrong.
`403` | Forbidden -- API Key is not authorized to perform this action.
`404` | Not Found -- The requested resource could not be found.
`405` | Method Not Allowed -- Request URL invalid.
`406` | Not Acceptable -- You requested a format that isn't json.
`410` | Gone -- The requested resource is no longer available.
`422` | Unprocessable Entity -- validation failed.
`429` | Too Many Requests -- You're making too many requests.
`500` | Internal Server Error -- We had a problem with our server. Try again later.
`503` | Service Unavailable -- We're temporarily offline for maintenance. Please try again later.

## Responses

### Exceptional errors
Exceptions vary in format. Please see the right hand panel for examples.

Attribute  | Type     | Meaning
---------- | -------- | -----------------
`type`     | string   | `forbidden`, `not_found`, `routing_error`, `parameter_missing`, `unpermitted_parameters`
`message`  | string   | Description of the error.
`detail`   | object   | Detailed information on the error, depending on the error.

> not_found

```json
{
    "message": "Resource not found: Couldn't find Order with 'id'=232323 [WHERE \"orders\".\"deleted_at\" IS NULL AND \"orders\".\"company_id\" = $1]",
    "type": "not_found",
    "id": "232323",
    "model": "Order",
    "primary_key": "id"
}
```

> parameter_missing

> unpermitted_parameters

```json
{
    "error": "found unpermitted parameter: :total",
    "params": [
        "total"
    ]
}
```

### Validation errors
Validation errors occur when a provided attribute does not meet the validation requirements on the model. The status code is always `422`.

> Example Order Validation Error

```json
{
	"type": "validation_error",
	"message": "First name Required, Last name Required, Email Required, and Guest Required",
	"errors": {
		"order": [{
			"field": "first_name",
			"code": "blank",
			"message": "Required"
		}, {
			"field": "last_name",
			"code": "blank",
			"message": "Required"
		}, {
			"field": "email",
			"code": "blank",
			"message": "Required"
		}, {
			"field": "guest",
			"code": "blank",
			"message": "Required"
		}],
		"tickets": {
			"2148082": [{
				"field": "guest",
				"code": "blank",
				"message": "can't be blank"
			}]
		}
	}
}
```

#### Format

Attribute             | Type     | Meaning
--------------------- | -------- | -----------------
`type`                | string   | always `validation_error`
`message`             | string   | All of the validation errors concatenated into a single message.
`errors`              | object   | Details on the individual validation errors. Look for the key relevant to the resource you are modifying. E.g. for Orders, the key is `order`
`errors.{model-name}` | array    | e.g. `errors.order` for Order.

#### Association errors
When you are submitting nested parameters, e.g. `tickets` with an `Order`, the errors associated to those resources are specified in an `array`, in the `errors` attribute, with the key being the name of the association. E.g. for `tickets` submitted along with an order, the key to access those is `errors.tickets`
Inside the association errors key, you will find a hash, indexed by the ID of the associated record. See example.

#### Error codes

`code`      | Meaning
---------- | ------------------------
`blank`    | attribute is required

