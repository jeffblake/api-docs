# Introduction

## REST

## Base URL

Api Version          | URL
-------------------- | -----------
Latest               | `https://app.guestmanager.com/api/public`
`v1`                 | `https://app.guestmanager.com/api/public/v1`

## Versioning
The version is specified in the request URL. If the version is omitted, the latest version will be used by default.

## Rate limiting
API requests are throttled by IP address and limited to 300 requests per 5 minute period.

## Tooling
Postman is a great app for testing and experimenting with our API.

## Feedback
Do you have a suggestion on how we can improve this API? Email us at support@guestmanager.com.

## Requests

### Headers
The following headers must be specified in all API requests.

Header               | Value
-------------------- | -----------
`Authorization`      | `Token abcdefg`
`Content-Type`       | `application/json`
`Accept`             | `application/json`

### Parameters
All parameters should be submitted as JSON, however url-encoded data is also suitable. Provide only the attributes that you wish to change - do not submit the entire object, as you will likely encounter an error due to read-only attributes.

## Responses
All responses are returned as JSON, along with a relevant status code.

You may change how results are returned by specifying an `adapter` in the `GET` request.

`adapter`       | Description
--------------- | -----------------
`attributes`    | Default. Array of objects, with no top-level key.
`json`*         | Array of objects, with a top-level key, and pagination information.
`json_api`**    | Conforms to the JSON API spec.

- * Alpha.
- ** Super Duper Alpha.

### Successful status codes
Code                 | Description
-------------------- | -----------
`200`                | OK
`201`                | Created
`204`                | No Content -- used for `DELETE` requests.

## Errors

### Error status codes

Error Code | Meaning
---------- | -------
`400`      | Bad Request
`401`      | Unauthorized -- Your API key is wrong.
`403`      | Forbidden -- API Key is not authorized to perform this action.
`404`      | Not Found -- The requested resource could not be found.
`405`      | Method Not Allowed -- Request URL invalid.
`406`      | Not Acceptable -- You requested a format that isn't json.
`410`      | Gone -- The requested resource is no longer available.
`422`      | Unprocessable Entity -- validation failed.
`429`      | Too Many Requests -- You're making too many requests.
`500`      | Internal Server Error -- We had a problem with our server. Try again later.
`503`      | Service Unavailable -- We're temporarily offline for maintenance. Please try again later.


### Exceptional errors
Exceptions vary in format. Please see the right hand panel for examples.

Attribute  | Type     | Meaning
---------- | -------- | -----------------
`type`     | string   | `forbidden`, `not_found`, `routing_error`, `parameter_missing`, `unpermitted_parameters`
`message`  | string   | Description of the error.
`detail`   | object   | Detailed information on the error, depending on the error.

> rate_limit_exceeded

{
    "type": "rate_limit_exceeded",
    "message": "Throttle limit reached. Retry later."
}

> not_found

```json
{
    "type": "not_found",
    "message": "Resource not found: Couldn't find Order with 'id'=1762272 [WHERE \"orders\".\"deleted_at\" IS NULL AND \"orders\".\"company_id\" = $1]",
    "detail": {
        "id": "1762272",
        "model": "Order",
        "primary_key": "id"
    }
}
```

> parameter_missing

```json
{
    "type": "parameter_missing",
    "message": "param is missing or the value is empty: order"
}
```

> unpermitted_parameters

```json
{
    "type": "unpermitted_parameters",
    "message": "found unpermitted parameter: :total",
    "detail": {
        "params": [
            "total"
        ]
    }
}
```

### Validation errors
Validation errors occur when a provided attribute does not meet the validation requirements on the model. The status code is always `422`.

> Example Validation Error

```json
{
    "type": "validation_error",
    "message": "Email is invalid",
    "errors": {
        "attributes": [
            {
                "field": "email",
                "label": "Email",
                "code": "invalid",
                "message": "is invalid"
            }
        ],
        "associations": {
            "tickets": {},
            "form_responses": {}
        }
    }
}
```

> Example Validation Error w/ Associations

```json
{
  "type": "validation_error",
  "message": "",
  "errors": {
      "attributes": [],
      "associations": {
          "tickets": {
              "2148094": {
                  "type": "validation_error",
                  "message": "Name can't be blank",
                  "errors": {
                      "attributes": [
                          {
                              "attribute": "name",
                              "label": "Name",
                              "code": "blank",
                              "message": "can't be blank"
                          }
                      ],
                      "associations": {}
                  }
              }
          },
          "form_responses": {}
      }
  }
}
```

#### Error response

Attribute             | Type     | Meaning
--------------------- | -------- | -----------------
`type`                | string   | always `validation_error`
`message`             | string   | All of the validation errors concatenated into a single message.
`errors`              | object   | Details on the individual validation errors. Look for the key relevant to the resource you are modifying. E.g. for Orders, the key is `order`
`errors[attributes]`  | array    | Errors on the object itself.
`errors[associations]`| hash     | Errors on associated objects.

#### Error node

Attribute             | Type     | Meaning
--------------------- | -------- | -----------------
`attribute`           | string   | The attribute on the model that triggered the error.
`label`               | string   | A human readable version of the attribute.
`code`                | string   | The type of validation error. See below for possibile codes.
`message`             | string   | A human readable version of the `code`

#### Association errors
When you are submitting nested parameters, e.g. `tickets` with an `Order`, the errors associated to those resources are specified in an `array`, in the `errors` attribute, with the key being the name of the association. E.g. for `tickets` submitted along with an order, the key to access those is `errors.associations.tickets`
Inside the association errors key, you will find a hash, indexed by the ID of the associated record. See example.

#### Validation error codes
https://github.com/rails/rails/blob/master/activemodel/lib/active_model/locale/en.yml

`code`     | Meaning
---------- | ------------------------
`blank`    | attribute is required
`invalid`  | attribute format is invalid.