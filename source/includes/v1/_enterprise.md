# Enterprise

The Enterprise API is only available for private label and reseller clients. These endpoints require an Enterprise API Key
(different from the one described in the introduction). Please contact support to get your API key.

## Base URL

Api Version          | URL
-------------------- | -----------
Latest               | `https://app.guestmanager.com/api/public/enterprise`
`v1`                 | `https://app.guestmanager.com/api/public/enterprise/v1`

## Authentication
Authentication is done through an `Authorization` header. Please see the example on the right. A successful request (for testing purposes) will respond
with your enterprise name and `ID`. All API requests are stateless, so include this `Authorization` header in all requests, or you will receive
a response code `401` with body `HTTP Token: Access denied.`

> Request

```shell
curl -X GET \
  https://app.guestmanager.com/api/public/enterprise/v1 \
  -H 'Authorization: Token abcedf123' \
  -H 'Content-Type: application/json'
```

> Response

```json
{
  "id": 0,
  "name": "Your enterprise name"
}
```

### Using the API endpoints above
To use the API endpoints above on behalf of your company clients, you must use a company API Key (not your enterprise API key). You can get the
company API key below when creating the company. Be sure to store this key somewhere in your database.

## Company object

```json
{
    "id": 4412,
    "name": "Company ABC",
    "password": "****",
    "pin": 5988,
    "created_at": "2018-12-07T12:52:54.665871Z",
    "updated_at": "2018-12-07T12:52:55.939928Z",
    "api_keys": [
        {
            "id": 0,
            "name": null,
            "access_token": "....",
            "read": true,
            "write": true
        },
        {
            "id": 0,
            "name": null,
            "access_token": "....",
            "read": true,
            "write": false
        }
    ],
    "users": [
        {
            "id": 9175,
            "name": "John Doe",
            "email": "john@doe.com"
        }
    ],
    "address": {
        "id": 0,
        "address1": null,
        "city": null,
        "zipcode": null,
        "state_name": null,
        "state_code": null,
        "country_name": "United States",
        "country_code": "US"
    }
}
```

Companies are your clients. Every company is a separate silo of data: events, contacts, tickets, etc.

### Company fields

Attribute                      | Type     | Description
------------------------------ | -------- | -----------
`id`                         | `int`  | ID of the company. Can, for example, be used to query the events endpoint using the `company_id` parameter.
`name`                         | `string`  | Name of the company.
`password`                     | `string`  | The password used to log into the Check In App.
`pin`                          | `string`  | The default PIN number to log into the Check In App with.


### Company relationships

Key                      | Relationship   | Type
------------------------ | -------------- | -----------
`address`                | `Address`      | `object`
`api_keys`               | `ApiKey`       | `array`
`users`                  | `CompanyUser`  | `array`


## List companies

<div class="api-endpoint">
	<div class="endpoint-data">
		<i class="label label-get">GET</i>
		<h6>/companies</h6>
	</div>
</div>

> Request


```shell
curl -X GET \
  https://app.guestmanager.com/api/public/enterprise/v1/companies \
  -H 'Authorization: Token abcedf123' \
  -H 'Content-Type: application/json'
```

> Response

```json
{
    "data": [
        {
            "id": 4412,
            "name": "Company a"
        },
        {
            "id": 4413,
            "name": "Company b"
        }
    ],
    "meta": {
        "count": 2,
        "total": 2,
        "page": {
            "number": 1,
            "size": 10,
            "next": null,
            "prev": null,
            "total": 1,
            "last": true,
            "first": true,
            "out_of_range": false
        },
        "links": {
            "self": ".../api/public/enterprise/v1/companies",
            "next": null,
            "prev": null,
            "last": ".../api/public/enterprise/v1/companies?page%5Bnumber%5D=1",
            "first": ".../api/public/enterprise/v1/companies?page%5Bnumber%5D=1"
        }
    }
}
```

### Request parameters

Parameter                        | Type        | Required  | Default | Description
-------------------------------- | ----------- | --------- | ---------- | -----------
`page[size]`                     | `integer`   | *no*     | `10`      | How many records to return per request. Default is `10`, maximum is `100`
`page[number]`                   | `integer`   | *no*     | `1`       | The page of records to request.
`sort[{field}]`                  | `string`    | *no*     | *none*       | The field to sort results by. Can be `id`, `name`, with value `asc` or `desc`
`fields`                         | `string`    | *no*     | `id,name` | Comma separated list of attributes to return. See company object for possible fields.
`include`                        | `string`    | *no*     | ` `  | Relationships to include. See company object for possible relationships.


### Response data

An array of company objects will be returned in the `data` key. Pagination information is in the `meta` key.

## Create company

<div class="api-endpoint">
	<div class="endpoint-data">
		<i class="label label-post">POST</i>
		<h6>/companies</h6>
	</div>
</div>

### Request parameters

Parameter                           | Type        | Required  | Description
----------------------------------- | ----------- | --------- | ----------
`company[name]`                     | `string`    | *yes*     | Company name.
`company[address][country_code]`    | `string`    | *yes*     | ISO code of the company's country.


> Sample request

```shell
curl -X POST \
  https://app.guestmanager.com/api/public/enterprise/v1/companies \
  -H 'Authorization: Token abcdefg' \
  -H 'Content-Type: application/json' \
  -d '{
	"company": {
		"name": "New company",
		"address": {
			"country_code": "US"
		}
	}
}'
```

### Response

You will receive back two API keys, one authorized for read only, and the other authorized for read and writes. Please store the Company
`id`, and `api_keys` in your own database, as you will need these to perform API requests on behalf of your clients.

The `password` and `pin` are used to log in to the iOS Check In App.

> Sample response

```json
{
  "id": 10,
  "name": "New company",
  "password": "******",
  "pin": "1234",
  "address": {
    "country_code": "US"
  },
  "api_keys": [
    {
      "id": 1234,
      "name": null,
      "access_token": "....",
      "read": true,
      "write": false
    },
    {
      "id": 1235,
      "name": null,
      "access_token": "....",
      "read": true,
      "write": true
    }
  ]
}
```

## List events

See [**Objects**](#objects-event) section for details on the fields and relationships.

<div class="api-endpoint">
	<div class="endpoint-data">
		<i class="label label-get">GET</i>
		<h6>/events</h6>
	</div>
</div>

### Request parameters

> Sample request

```shell
curl -X GET \
  https://app.guestmanager.com/api/public/enterprise/v1/events \
  -H 'Authorization: Token abcedf' \
  -H 'Content-Type: application/json' \
  -d '{
	"filter": {
		"company_id": 123
	},
	"sort": {
		"starts_at": "asc"
	},
	"page": {
		"size": 10,
		"number": 2
	},
	"include": "registration_types.prices"
}'
```

> Sample response

Please refer to the [List events endpoint](#events-list-events) for a complete list of request parameters. In addition to those, the following are exclusive
to the enterprise endpoint:

Parameter                        | Type        | Required  | Default | Description
-------------------------------- | ----------- | --------- | ---------- | -----------
`filter[company_id]`             | `integer`   | *no*     | *none*  | Filter by company.

