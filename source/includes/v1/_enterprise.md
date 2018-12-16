# Enterprise

The Enterprise API is only available for private label and reseller clients. These endpoints require an Enterprise API Key
(different from the one described in the introduction). Please contact support to get your API key.

## Base URL

Api Version          | URL
-------------------- | -----------
Latest               | `https://app.guestmanager.com/api/public/enterprise`
`v1`                 | `https://app.guestmanager.com/api/public/enterprise/v1`

## Authentication
Please see the Authentication section under Topics.

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

## Using the API endpoints above
To use the API endpoints above on behalf of your company clients, you must use a company API Key (not your enterprise API key). You can get the
company API key below when creating the company. Be sure to store this key somewhere in your database.

## Create company

<div class="api-endpoint">
	<div class="endpoint-data">
		<i class="label label-post">POST</i>
		<h6>/companies</h6>
	</div>
</div>

### Request parameters

Attribute                           | Type        | Required  | Description
----------------------------------- | ----------- | --------- | ----------
`company[name]`                     | `string`    | *yes*     | Company name.
`company[address][country_code]`    | `integer`   | *yes*     | ISO code of the company's country.


> Sample request

```json
{
  "company": {
    "name": "New company",
    "address": {
      "country_code": "US"
    }
  }
}
```

### Response

You will receive back two API keys, one authorized for read only, and the other authorized for read and writes. Please store the Company
`id`, and `api_keys` in your own database, as you will need these to perform API requests on behalf of your clients.

The `password` and `pin` are used to log in to the iOS Check In App.

> Sample response

```json
{
  "id": 10,
  "name": "Company name",
  "password": "******",
  "pin": "1234"
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
