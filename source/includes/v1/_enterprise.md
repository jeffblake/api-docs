# Enterprise

The Enterprise API is only available for private label and reseller clients. These endpoints require an Enterprise API Key
(different from the one described in the introduction). Please contact support to get your API key.

## Base URL

Api Version          | URL
-------------------- | -----------
Latest               | `https://guestmanager.com/api/public/enterprise`
`v1`                 | `https://guestmanager.com/api/public/enterprise/v1`

## Authentication
Please see the Authentication section under Topics.

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

Attribute                      | Type     | Required   | Description
------------------------------ | -------- | --------- | ----------
`company[name]`                | `string`   | *yes*    | Company name.
`company[address_attributes][country_code]`    | `integer`   | *yes*    | ISO code of the company's country.

> Sample request

```json
{
  "company": {
    "name": "New company",
    "address_attributes": {
      "country_code": "US "
    }
  }
}
```

### Response

> Sample response

```json
{
  "name": "Company name",
  "password": "******",
  "pin": "1234"
  "api_key": "*******"
}
```