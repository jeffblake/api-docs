# Topics

## Changelog

`v2`

* Collection endpoints now return records in a top level `data` key, with a `meta` key with pagination details and links.
* Standardized request parameters for sorting, filtering, paging, and including relationships and fields.
* List all endpoints have a different response format (pagination details is included), and is more performant
* Fields that represent money are now returned in a different format: an object with three keys: `amount` (in cents as an integer), `decimal` (string type), and `formatted` (includes currency symbol and delimiters)
* The endpoint for creating ticket types for an event has changed. Please see [endpoint details](#events-add-ticket-type)
* Ticket tier has been renamed to Registration type
* `guest_id` has changed to `contact_id`. Contact ID is different than Guest ID, it is a company-specific ID for that user.

## Getting started

### Tooling
Postman is a great app for testing and experimenting with our API. You can download it here: <https://www.getpostman.com/>

## Base URL

Api Version          | URL
-------------------- | -----------
Latest (v2)          | `https://app.guestmanager.com/api/public`
`v2`                 | `https://app.guestmanager.com/api/public/v2`
`v1`                 | `https://app.guestmanager.com/api/public/v1`

### Versioning
The version is specified in the request URL. If the version is omitted, the latest version will be used by default.

### Rate limiting
API requests are throttled by IP address and limited to 300 requests per 1 minute period. If you need to handle more, please contact support.
The `Retry-After` header will specify when you can continue making requests.

## Authentication

Authentication is done through the `Authorization` request header. The value should be in the format `Token abcdefg` where `abcdefg` is replaced with your API Key.

> Request (Using Company API)

```shell
curl -X GET \
  https://app.guestmanager.com/api/public/v2 \
  -H 'Authorization: Token abcedf123' \
  -H 'Content-Type: application/json'
```

> Response

```json
{
  "id": 0,
  "name": "Your company name"
}
```


### API keys
API Keys are created in the company dashboard under the Config menu. API keys are authorized for either `read`, `write`, or both.

### API key permissions
API Keys are authorized for `read`, `write`, or both.

Attribute                 | Allowed request methods
------------------------- | -----------------
`read`                    | `GET`
`write`                   | `POST`, `PATCH`, `DELETE`



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
All responses are returned as JSON, along with a relevant status code. If the status code returned is in the `2xx` range, you may assume the
request succeeded. Therefore, rather than check if the JSON response has an error, always check the status code instead.

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
`400`      | Bad Request - check response for details and fix.
`401`      | Unauthorized -- Your API key is wrong.
`403`      | Forbidden -- API Key is not authorized to perform this action.
`404`      | Not Found -- The requested resource could not be found.
`405`      | Method Not Allowed -- Request URL invalid.
`406`      | Not Acceptable -- You requested a format that isn't json.
`410`      | Gone -- The requested resource is no longer available.
`422`      | Unprocessable Entity -- validation failed - check error details and correct.
`429`      | Too Many Requests -- You're making too many requests.
`500`      | Internal Server Error -- We had a problem with our server. Please contact support.
`503`      | Service Unavailable -- We're temporarily offline for maintenance. Please try again later.


### Exceptional errors
Exceptional errors indiciate a problem with your request format. Please see the right hand panel for examples.

Attribute  | Type     | Meaning
---------- | -------- | -----------------
`type`     | string   | `forbidden`, `not_found`, `routing_error`, `parameter_missing`, `unpermitted_parameters`
`message`  | string   | Description of the error.
`detail`   | object   | Detailed information on the error, depending on the error.

> rate_limit_exceeded

```json
{
    "type": "rate_limit_exceeded",
    "message": "Throttle limit reached. Retry later."
}
```

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
                "name": null,
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

### Error response

Attribute             | Type       | Meaning
--------------------- | ---------- | -----------------
`type`                | `string`   | always `validation_error`
`message`             | `string`   | All of the validation errors concatenated into a single message.
`errors`              | `object`   | Details on the individual validation errors. Look for the key relevant to the resource you are modifying. E.g. for Orders, the key is `order`
`errors[attributes]`  | `array`    | Errors on the object itself.
`errors[associations]`| `hash`     | Errors on associated objects.

### Error node

Attribute             | Type       | Meaning
--------------------- | ---------- | -----------------
`attribute`           | `string`   | The attribute on the model that triggered the error.
`label`               | `string`   | A human readable version of the attribute name.
`name`                | `string`   | If the relevant attribute is a relationship, we will add the name of that record here.
`code`                | `string`   | The type of validation error. See below for possibile codes.
`message`             | `string`   | A human readable version of the `code`
`detail`              | `object`   | Any extra attributes that may be useful, depending on the error.


### Association errors
When you are submitting nested parameters, e.g. `tickets` with an `Order`, the errors associated to those resources are specified in an `array`, in the `errors` attribute, with the key being the name of the association. E.g. for `tickets` submitted along with an order, the key to access those is `errors.associations.tickets`
Inside the association errors key, you will find a hash, indexed by the ID of the associated record. See example.

### Validation error codes

`code`     | Meaning
---------- | ------------------------
`blank`    | attribute is required
`invalid`  | attribute format is invalid.

## Transformations

### Images
Many resources have images attached them. By default we will only include the URL to the original, unaltered image that was uploaded into our system.
You can also dynamically resize, alter, and transform images by specifying additional request parameters.

This is achieved by specifying an `images` request parameter in either `GET` endpoint (list collection, get individual resource)

Parameter           | Type            | Description
-------------- | -----------------  | ----------------------------------
`images[{resource_name}]`     | `object`               | Which resource to target. This allows you to target relationships of an object as well.
`images[{resource_name}][{field_name}]`         | `array`                | Provide an array of transformations. A URL to the image will be returned for each.


Let's look at an example: requesting thumbnail images for event categories.

<div class="center-column"></div>
```json
{
  "images": { # Top level request parameter
    "category": { # Specify which resource type
      "image": [ # Specify which `field` on the resource
        {
          "key": "my_thumbnail", # Name your key, this will be returned back to you
          "options": { # Specify image transformations
            "resize": "250x250>"
          }
        }
      ]
    }
  }
}
```

#### Transformation `options`

Parameter         | Type            | Description
--------------    | -----------------  | ----------------------------------
`resize`          | `string`           | Resize the image. For complete reference, refer to [ImageMagick reference](https://www.imagemagick.org/script/command-line-processing.php#geometry)
`auto_orient`     | `boolean`          | Attempts to auto-orient the image. For example, iOS selfies can typically benefit from this option.

We also support any options that ImageMagick supports. For a complete list of options, please see [ImageMagick's Command line reference](https://www.imagemagick.org/script/command-line-processing.php)


## Pagination

All requests to a `GET` collection endpoint are paginated. The default is `10` records per page, and the maximum is `100` per page. Some resources
may have a per page limit (for example, `50` is the maximum for events).

### Pagination request parameters

Parameter           | Default            | Description
-------------- | -----------------  | ----------------------------------
`page[number]`     | `1`               | The page to return records for.
`page[size]`         | `10`                | How many records to return in each response.

> Sample pagination response

```json
{
  "data": [...],
  "meta": {
      "count": 10,
      "total": 14633,
      "page": {
          "number": 1,
          "size": 10,
          "next": 2,
          "prev": null,
          "total": 1464,
          "last": false,
          "first": true,
          "out_of_range": false
      },
      "links": {
          "self": ".../api/public/v2/events?page[number]=1",
          "next": ".../api/public/v2/events?page%5Bnumber%5D=2",
          "prev": null,
          "last": ".../api/public/v2/events?page%5Bnumber%5D=1464",
          "first": ".../api/public/v2/events?page%5Bnumber%5D=1"
      }
  }
}
* Note: Full URLs omitted for brevity
```

### Pagination response meta data

All pagination information is returned in a `meta` key in the response. Please see example on the right.


For convenience, we include links to fetch the next, previous, first, and last pages. These links include your original request parameters, such
as `filter` and `sort`

Parameter                      | Type         | Description
------------------------------ | ------------ | ----------------------------------
`meta[count]`                  | `integer`    | The number of records returned in this request.
`meta[total]`                  | `integer`    | The total number of records, across all pages.
`meta[page][number]`           | `integer`    | The current page number.
`meta[page][size]`             | `integer`    | The page size.
`meta[page][next]`             | `integer`    | The next page number. `null` if no next page.
`meta[page][prev]`             | `integer`    | The previous page number. `null` if no previous page.
`meta[page][total]`            | `integer`    | Total number of pages.
`meta[page][last]`             | `integer`    | The last page number.
`meta[page][first]`            | `integer`    | The first page number.
`meta[page][out_of_range]`     | `boolean`    | **true** if the requested page number does not match any results.
`meta[links][self]`            | `URL`        | Original request URL.
`meta[links][next]`            | `URL`        | URL to retrieve next page of results. `null` if no next page.
`meta[links][prev]`            | `URL`        | URL to retrieve previous page of results. `null` if no previous page.
`meta[links][last]`            | `URL`        | URL of the last page of results.
`meta[links][first]`           | `URL`        | URL of the first page of results.


## Filtering

> Filtering responses

```shell
curl -X GET \
  http://app.guestmanager.test:3000/api/public/v2/events \
  -H 'Authorization: Token ....' \
  -H 'Content-Type: application/json' \
  -d '{
	"filter": {
		"ids": "1,2,3"
	}
}'
```

For `GET` requests to a collection, e.g. `/events`, you can filter data using the `filter` request parameter. More details on which
fields can be filtered on are described in the relevant endpoint.

Parameter                    | Format                                        | Example
--------------------         | ----------------------------------------      | ----------------------------------
`filter[ids]`                | Comma separated string or JSON array.         | `"1,2,3"` or ```json {"ids": [1,2,3]}```
`filter[created_at][from]`   | `date` or `datetime`                          | `2018-05-25`
`filter[created_at][to]`     | `date` or `datetime`                          | `2018-05-25`



## Sorting

> Sorting responses

```shell
curl -X GET \
  http://app.guestmanager.test:3000/api/public/v2/events \
  -H 'Authorization: Token ....' \
  -H 'Content-Type: application/json' \
  -d '{
	"sort": {
		"starts_at": "asc"
	}
}'
```

For `GET` requests to a collection, e.g. `/events`, you can sort responses using the `sort` request parameter. More details on which
fields can be sorted on are described in the relevant endpoint.

Parameter           | Value
------------------- | -----------------
`sort[{field}]`     | `asc` or `desc`

Where you replace `{field}` with the field to sort on, and specify the value as `asc` or `desc`. You may sort on multiple fields.

## Fields and relationships
To increase performance and optimize network traffic, you may specify only the fields and relationships you interested in.
Refer to a specific resource endpoint to see which fields and relationships are available.

Parameter      | Options
-------------- | -----------------
`fields`       | Comma separated string of the fields you are interested in for that particular resource.
`include`      | Comma separated string of the relationships you are interested in for that particular resource.

Lists of available fields and relationships are specified in the collection endpoints.
