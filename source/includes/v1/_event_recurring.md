# Recurring events
Top level non-bookable events that serve as the wrapper around individual event date/times. The ID of the class can be used to query against the Events API to return date/times for that series.

See [**Objects**](#objects-recurring-event) section for details on the fields and relationships.

## List recurring events

<div class="api-endpoint">
	<div class="endpoint-data">
		<i class="label label-get">GET</i>
		<h6>/recurring_events</h6>
	</div>
</div>

> List recurring events

```shell
curl -X GET \
  https://app.guestmanager.com/api/public/v2/recurring_events \
  -H 'Authorization: Token abcdefg' \
  -H 'Content-Type: application/json' \
```

> Response

```json
{
    "data": [
        {
            "id": 69956,
            "name": "Girls' Night In",
            "slug": "girls-night-in",
            "calendar_id": null,
            "position": 1
        },
        {
            "id": 69929,
            "name": "Father's Day Roast",
            "slug": "father-s-day-roast",
            "calendar_id": null,
            "position": 1
        },
        ...
    ],
    "meta": {
        "count": 10,
        "total": 37,
        "page": {
            "number": 1,
            "size": 10,
            "next": 2,
            "prev": null,
            "total": 4,
            "last": false,
            "first": true,
            "out_of_range": false
        },
        "links": {
            "self": "https://app.guestmanager.com/api/public/v2/recurring_events",
            "next": "https://app.guestmanager.com/api/public/v2/recurring_events?page%5Bnumber%5D=2",
            "prev": null,
            "first": "https://app.guestmanager.com/api/public/v2/recurring_events?page%5Bnumber%5D=1",
            "last": "https://app.guestmanager.com/api/public/v2/recurring_events?page%5Bnumber%5D=4"
        }
    }
}
```

### Request parameters

Parameter                        | Type        | Required | Default   | Description
-------------------------------- | ----------- | -------- | --------- | -----------
`page[size]`                     | `integer`   | *no*     | `10`      | How many records to return per request. Default is `10`, maximum is `50`
`page[number]`                   | `integer`   | *no*     | `1`       | The page of records to request.
`sort[{field}]`                  | `string`    | *no*     | *none*    | Replace `{field}` with one of `id`, `created_at`, `updated_at`, `position`, and set the value to `asc` or `desc`. You may specify multiple sort fields.
`fields`                         | `string`    | *no*     | `all`     | Comma separated list of attributes to return.
`include`                        | `string`    | *no*     | *none*    | Relationships to include.
`filter[published_at]`           | `string`    | *no*     | *none*    | Values: `published`, `unpublished`

