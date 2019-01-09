# Venues

See [**Objects**](#objects-venue) section for details on the fields and relationships.

## List venues

<div class="api-endpoint">
	<div class="endpoint-data">
		<i class="label label-get">GET</i>
		<h6>/venues</h6>
	</div>
</div>

> List venues with addresses

```shell
curl -X GET \
  'https://app.guestmanager.com/api/public/v2/venues?include=address' \
  -H 'Authorization: Token abcdefg' \
  -H 'Content-Type: application/json' \
```

> Response

```json
{
    "data": [...],
    "meta": {
        "count": 8,
        "total": 8,
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
            "self": ".../api/public/v2/venues?include=address",
            "next": null,
            "prev": null,
            "last": ".../api/public/v2/venues?include=address&page%5Bnumber%5D=1",
            "first": ".../api/public/v2/venues?include=address&page%5Bnumber%5D=1"
        }
    }
}
```

### Request parameters

Parameter                        | Type        | Required | Default    | Description
-------------------------------- | ----------- | -------- | ---------- | -----------
`page[size]`                     | `integer`   | *no*     | `10`       | How many records to return per request. Default is `10`, maximum is `100`
`page[number]`                   | `integer`   | *no*     | `1`        | The page of records to request.
`sort[{field}]`                  | `string`    | *no*     | *none*     | Replace `{field}` with one of `id`, `created_at`, `updated_at`, `name`, and set the value to `asc` or `desc`. You may specify multiple sort fields.
`fields`                         | `string`    | *no*     | `id,name`  | Comma separated list of attributes to return.
`include`                        | `string`    | *no*     | *none*     | Relationships to include. See `Venue` object for possible relationships.


## Create venue

<div class="api-endpoint">
	<div class="endpoint-data">
		<i class="label label-post">POST</i>
		<h6>/venues</h6>
	</div>
</div>

> Create venue (minimum parameters)

```shell
curl -X POST \
  https://app.guestmanager.com/api/public/v2/venues \
  -H 'Authorization: Token abcdefg' \
  -H 'Content-Type: application/json' \
  -d '{
	"venue": {
		"name": "The Rio Theatre",
		"time_zone": "Pacific Time (US & Canada)"
	}
}'
```

> Response

```json
{
    "id": 3245,
    "name": "The Rio Theatre",
    "description": null,
    "slug": "the-rio-theatre",
    "created_at": "2019-01-07T20:33:44.583012Z",
    "updated_at": "2019-01-07T20:33:44.583012Z",
    "time_zone": "Pacific Time (US & Canada)",
    "tzinfo": {
        "name": "Pacific Time (US & Canada)",
        "identifier": "America/Los_Angeles",
        "offset": -28800,
        "formatted_offset": "-08:00"
    },
    "address": null
}
```

> Create venue (utilizing all parameters)

```shell
curl -X POST \
  https://app.guestmanager.com/api/public/v2/venues \
  -H 'Authorization: Token abcdefg' \
  -H 'Content-Type: application/json' \
  -d '{
    "venue": {
        "name": "The Rio Theatre",
        "description": "its around the corner",
        "time_zone": "Pacific Time (US & Canada)",
        "address": {
            "address1": "123 Main st",
            "city": "Vancouver",
            "zipcode": "V6T2J3",
            "country_code": "CA",
            "state_code": "BC"
        }
    }
}'
```

> Response

```json
{
    "id": 3246,
    "name": "The Rio Theatre",
    "description": "its around the corner",
    "slug": "the-rio-theatre-7ea12f80-35c0-4599-bdfc-3ef7c7e9f658",
    "created_at": "2019-01-07T20:35:48.650021Z",
    "updated_at": "2019-01-07T20:35:48.650021Z",
    "time_zone": "Pacific Time (US & Canada)",
    "tzinfo": {
        "name": "Pacific Time (US & Canada)",
        "identifier": "America/Los_Angeles",
        "offset": -28800,
        "formatted_offset": "-08:00"
    },
    "address": {
        "id": 144350,
        "address1": "123 Main st",
        "city": "Vancouver",
        "zipcode": "V6T2J3",
        "state_name": "British Columbia",
        "state_code": "BC",
        "country_name": "Canada",
        "country_code": "CA"
    }
}
```

### Parameters

Parameter                          | Type        | Required        | Description
---------------------------------- | ----------- | --------------- | -------------------------
`venue[name]`                      | `string`    | Yes             | Name of the venue.
`venue[description]`               | `string`    | No              | Any additional details about the venue.
`venue[time_zone]`                 | `string`    | Yes             | Time zone. See Object reference for list of time zones.
`venue[address]`                   | `object`    | No              | Venue address. See Object reference for parameters.