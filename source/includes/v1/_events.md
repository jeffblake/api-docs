# Events

See [**Objects**](#objects-event) section for details on the fields and relationships.

## List events

<div class="api-endpoint">
	<div class="endpoint-data">
		<i class="label label-get">GET</i>
		<h6>/events</h6>
	</div>
</div>

> List events (no parameters)

```shell
curl -X GET \
  https://app.guestmanager.com/api/public/v2/events/ \
  -H 'Authorization: Token abcdefg' \
  -H 'Content-Type: application/json' \
```

> List events with registration types and price information, sorted by `starts_at`

```shell
curl -X GET \
  https://app.guestmanager.com/api/public/v2/events/ \
  -H 'Authorization: Token abcdefg' \
  -H 'Content-Type: application/json' \
  -d '{
	"include": "registration_types.prices",
	"sort": {
		"starts_at": "asc"
	}
}'
```

> Response

```json
{
    "data": [
        {
            "id": 59978,
            "name": "Gourmet Steam Oven",
            "slug": "gourmet-steam-oven-10-30am-12-00pm",
            "venue_id": 1989,
            "parent_event_id": 59918,
            "calendar_id": null,
            "published_at": "2016-10-17T01:08:42.038414Z",
            "start": {
                "tz": "Melbourne",
                "local": "2016-10-28T10:30:00+11:00",
                "utc": "2016-10-27T23:30:00Z"
            },
            "end": {
                "tz": "Melbourne",
                "local": "2016-10-28T12:00:00+11:00",
                "utc": "2016-10-28T01:00:00Z"
            },
            "registration_types": [
                {
                    "id": 24,
                    "variant_id": 1867,
                    "name": "General admission",
                    "description": null,
                    "prices": [
                        {
                            "decimal": "0.0",
                            "amount": 0,
                            "currency": "AUD",
                            "default": true,
                            "formatted": "$0.00"
                        }
                    ]
                }
            ]
        },
        ...
    ],
    "meta": {
        "count": 10,
        "total": 4602,
        "page": {
            "number": 1,
            "size": 10,
            "next": 2,
            "prev": null,
            "total": 461,
            "last": false,
            "first": true,
            "out_of_range": false
        },
        "links": {
            "self": "https://app.guestmanager.com/api/public/v2/events/",
            "next": "https://app.guestmanager.com/api/public/v2/events?include=registration_types.prices&page%5Bnumber%5D=2&sort%5Bstarts_at%5D=asc",
            "prev": null,
            "first": "https://app.guestmanager.com/api/public/v2/events?include=registration_types.prices&page%5Bnumber%5D=1&sort%5Bstarts_at%5D=asc",
            "last": "https://app.guestmanager.com/api/public/v2/events?include=registration_types.prices&page%5Bnumber%5D=461&sort%5Bstarts_at%5D=asc"
        }
    }
}
```

### Request parameters

Parameter                        | Type        | Required  | Default | Description
-------------------------------- | ----------- | --------- | ---------- | -----------
`page[size]`                     | `integer`   | *no*     | `10`      | How many records to return per request. Default is `10`, maximum is `50`
`page[number]`                   | `integer`   | *no*     | `1`       | The page of records to request.
`sort[{field}]`                    | `string`    | *no*     | *none*       | Replace `{field}` with one of `id`, `name`, `starts_at`, `ends_at`, and set the value to `asc` or `desc`. You may specify multiple sort fields.
`fields`                         | `string`    | *no*     | `id,name` | Comma separated list of attributes to return. See company object for possible fields.
`include`                        | `string`    | *no*     | *none*  | Comma separated list of relationships to include.
`filter[published]`             | `boolean`   | *no*     | *none*  | `true` or `false`
`filter[company_id]`             | `integer`   | *no*     | *none*  | Filter by company.
`filter[venue_id]`               | `integer`   | *no*     | *none*  | Filter by venue.
`filter[category_id]`            | `integer`   | *no*     | *none*  | Filter by category.
`filter[parent_event_id]`               | `integer`   | *no*     | *none*  | Filter by recurring event.
`filter[starts_at][from]`       | `date`   | *no*     | *none*  | Filter events on or after this date. *
`filter[starts_at][to]`         | `date`   | *no*     | *none*  | Filter events before this date. *
`filter[ends_at][from]`       | `date`   | *no*     | *none*  | Filter events ending on or after this date. Generally, filtering by `starts_at` instead is more desirable.
`filter[ends_at][to]`         | `date`   | *no*     | *none*  | Filter events ending before this date. *
`filter[status]`         | `string`   | *no*     | *none*  | `this_week`, `next_week`, `next_month`, `active`, `over`, `past`, `future`, `today`, `tomorrow`<br>`active`: events in progress and future events<br>`over`: events where `ends_at < current time`<br>`future`: events with start dates in the future (excludes active events)<br>`past`: events where starts_at is less than current time<br>`this_week`: Monday-Sunday<br>`next_week`: Next Monday-Sunday


* When using date ranges, you can specify dates in any common formats such as 2018-05-25, as well as `iso8601` formats. When both `from` and `to` are specified, the corresponding SQL query is a `BETWEEN`, and we automatically convert the `from` date to beginning of day, and the `to` date to end of day (if inputs do not specify time information).
* For convenience, you can also filter by date using the `filter[status]` parameter. For example, `filter[status]=active` will return events with a `starts_at` greater than now.

* `include`
  * `registration_types`
  * `registration_types.prices` Includes registration types and prices
  * `registration_types.stock_item` Includes inventory details. **Heads up:** This data may be cached and out of date.
  * `company`
  * `venue`
  * `categories`
  * Example including multiple relationships: `registration_types.prices,company,venue`



## Fetch event

<div class="api-endpoint">
	<div class="endpoint-data">
		<i class="label label-get">GET</i>
		<h6>/events/{id}</h6>
	</div>
</div>

> Fetch event

```shell
curl -X GET \
  https://app.guestmanager.com/api/public/v2/events/123456 \
  -H 'Authorization: Token abcdefg' \
  -H 'Content-Type: application/json' \
```

## Create event

<div class="api-endpoint">
	<div class="endpoint-data">
		<i class="label label-post">POST</i>
		<h6>/events</h6>
	</div>
</div>

> Create event request

```shell
curl -X POST \
  http://app.guestmanager.com/api/public/v2/events/ \
  -H 'Authorization: Token abcdefg' \
  -H 'Content-Type: application/json' \
  -d '{
	"event": {
		"name": "New event",
		"starts_at": "2018-12-28T04:00:00Z",
		"ends_at": "2018-12-28T08:00:00Z",
		"venue_id": 2847
	}
}'
```

> Create event response

```json
{
    "id": 71390,
    "name": "New event",
    "slug": "new-event",
    "venue_id": 2847,
    "parent_event_id": null,
    "calendar_id": null,
    "published_at": null,
    "start": {
        "tz": "Central Time (US & Canada)",
        "local": "2018-12-27T22:00:00-06:00",
        "utc": "2018-12-28T04:00:00Z"
    },
    "end": {
        "tz": "Central Time (US & Canada)",
        "local": "2018-12-28T02:00:00-06:00",
        "utc": "2018-12-28T08:00:00Z"
    },
    "venue": {
        "id": 2847,
        "name": "Texas Motor Speedway",
        "description": null,
        "slug": "texas-motor-speedway"
    },
    "categories": [],
    "registration_types": [],
    "list": {
        "id": 1016744,
        "name": "RLL Hospitality",
        "slug": "rll-hospitality",
        "status": "visible",
        "permanent_list_id": 27236,
        "image": null
    }
}
```

### Request parameters

Parameter                      | Type        | Required | Description
------------------------------ | ----------- | -------- | ----------
`event[name]`                  | `string`    | *yes*    | Name of the event.
`event[venue_id]`              | `integer`   | *yes*    | `id` of the venue. Please find or create a venue first.
`event[starts_at]`             | `datetime`  | *yes*    | Start date and time of the event. Provide UTC `iso8601` string
`event[ends_at]`               | `datetime`  | *yes*    | End date and time of the event. Provide UTC `iso8601` string
`event[published_at]`          | `datetime`  | *no*     | Set this to any date to publish the event.

## Update event

<div class="api-endpoint">
	<div class="endpoint-data">
		<i class="label label-post">PATCH</i>
		<h6>/events/{event-id}</h6>
	</div>
</div>

> Update event

```shell
curl -X PATCH \
  https://app.guestmanager.com/api/public/v2/events/71383 \
  -H 'Authorization: Token abcdefg' \
  -H 'Content-Type: application/json' \
  -d '{
	"event": {
		"name": "New name"
	}
}'
```

### Request parameters
See parameters for the create event endpoint.

## Add ticket type
Add an existing ticket type to this event.

<div class="api-endpoint">
	<div class="endpoint-data">
		<i class="label label-post">POST</i>
		<h6>/events/{event-id}/ticket_types/add</h6>
	</div>
</div>

> Add existing ticket type

```shell
curl -X POST \
  https://app.guestmanager.com/api/public/v2/events/71389/ticket_types/add \
  -H 'Authorization: Token abcdefg' \
  -H 'Content-Type: application/json' \
  -d '{
	"ticket_type_id": 2217
}'
```

> Response

```json
{
    "id": 19056,
    "created_at": "2019-01-07T21:46:39.605652Z",
    "updated_at": "2019-01-07T21:46:39.605652Z",
    "ticket_type_id": 2217,
    "event_id": 71389,
    "starts_at": null,
    "ends_at": null,
    "pdf_template_id": null,
    "ticket_type": {
        "id": 2217,
        "created_at": "2016-10-17T00:51:35.291358Z",
        "updated_at": "2019-01-07T21:46:39.619151Z",
        "archived_at": null,
        "name": "Free Discovery Product Demonstrations",
        "pdf_template_id": 704,
        "wallet_template_id": null,
        "attachable": true,
        "transferable": false,
        "include_name": true,
        "include_email": true,
        "require_name": true,
        "require_email": false,
        "enforce_barcode_pool": false,
        "attachment_name": "{{ticket.name}}"
    }
}
```

### Request parameters

Parameter                      | Type        | Required | Description
------------------------------ | ----------- | -------- | ----------
`ticket_type_id`               | `int`       | *yes*    | `ID` of the ticket type to add to this event.

## Create new ticket type
Create a new ticket type and add it to an event, all in one step. It is advised that you do not duplicate ticket type names, therefore it is
recommended to find or create the ticket type separately, and then add it to the event using the above endpoint.s

<div class="api-endpoint">
	<div class="endpoint-data">
		<i class="label label-post">POST</i>
		<h6>/events/{event-id}/ticket_types</h6>
	</div>
</div>

> Create basic ticket type and add it to event

```shell
curl -X POST \
  https://app.guestmanager.com/api/public/v2/events/71389/ticket_types/ \
  -H 'Authorization: Token abcdefg' \
  -H 'Content-Type: application/json' \
  -d '{
	"ticket_type": {
		"name": "GA"
	}
}'
```

> Response

```json
{
    "id": 19057,
    "created_at": "2019-01-07T21:56:42.769762Z",
    "updated_at": "2019-01-07T21:56:42.769762Z",
    "ticket_type_id": 7456,
    "event_id": 71389,
    "starts_at": null,
    "ends_at": null,
    "pdf_template_id": null,
    "ticket_type": {
        "id": 7456,
        "created_at": "2019-01-07T21:56:42.755038Z",
        "updated_at": "2019-01-07T21:56:42.774215Z",
        "archived_at": null,
        "name": "GA",
        "pdf_template_id": null,
        "wallet_template_id": null,
        "attachable": true,
        "transferable": true,
        "include_name": false,
        "include_email": false,
        "require_name": false,
        "require_email": false,
        "enforce_barcode_pool": false,
        "attachment_name": "{{ticket.name}}"
    }
}
```

### Request parameters

Parameter                                    | Type         | Required | Default    | Description
-------------------------------------------- | ------------ | -------- | ---------- | ------------------------
`ticket_type[name]`                          | `string`     | *yes*    |            | Name of the ticket type.
`ticket_type[display_name]`                  | `string`     | *no*     |            | Display name.
`ticket_type[pdf_template_id]`               | `string`     | *no*     | `null`     | Ticket design template ID.
`ticket_type[wallet_template_id]`            | `string`     | *no*     | `null`     | Apple Wallet design template ID.
`ticket_type[attachable]`                    | `boolean`    | *no*     | `true`     | `true` to include ticket as a PDF attachment, `false` to include as a download link instead.
`ticket_type[transferable]`                  | `boolean`    | *no*     | `true`     | Whether guests can transfer their ticket to someone else.
`ticket_type[include_name]`                  | `boolean`    | *no*     | `false`    | See object reference.
`ticket_type[require_name]`                  | `boolean`    | *no*     | `false`    | See object reference.
`ticket_type[include_email]`                 | `boolean`    | *no*     | `false`    | See object reference.
`ticket_type[require_email]`                 | `boolean`    | *no*     | `false`    | See object reference.
`ticket_type[enforce_barcode_pool]`          | `boolean`    | *no*     | `false`    | See object reference.

## List event lists

<div class="api-endpoint">
	<div class="endpoint-data">
		<i class="label label-get">GET</i>
		<h6>/events/{event-id}/lists</h6>
	</div>
</div>

> Fetch event lists

```shell
curl -X GET \
  'https://app.guestmanager.com/api/public/v2/events/12345/lists' \
  -H 'Authorization: Token abcedfg' \
  -H 'Content-Type: application/json' \
```

> Response

```json
{
    "data": [
        {
            "id": 1014210,
            "name": "RLL Hospitality",
            "slug": "rll-hospitality",
            "status": "visible",
            "permanent_list_id": 27236,
            "image": null,
            "permanent_list": {
                "id": 27236,
                "name": "RLL Hospitality",
                "slug": "rll-hospitality",
                "recurring": true,
                "status": "hidden"
            }
        },
        ...
    ],
    "meta": {
        "count": 10,
        "total": 24,
        "page": {
            "number": 1,
            "size": 10,
            "next": 2,
            "prev": null,
            "total": 3,
            "last": false,
            "first": true,
            "out_of_range": false
        },
        "links": {
            "self": "https://app.guestmanager.com/api/public/v2/events/70962/lists?include=permanent_list",
            "next": "https://app.guestmanager.com/api/public/v2/events/70962/lists?include=permanent_list&page%5Bnumber%5D=2",
            "prev": null,
            "first": "https://app.guestmanager.com/api/public/v2/events/70962/lists?include=permanent_list&page%5Bnumber%5D=1",
            "last": "https://app.guestmanager.com/api/public/v2/events/70962/lists?include=permanent_list&page%5Bnumber%5D=3"
        }
    }
}
```

### Request parameters

Parameter                        | Type        | Required  | Default | Description
-------------------------------- | ----------- | --------- | ---------- | -----------
`page[size]`                     | `integer`   | *no*     | `10`      | How many records to return per request. Default is `10`, maximum is `100`
`page[number]`                   | `integer`   | *no*     | `1`       | The page of records to request.
`sort[{field}]`                  | `string`    | *no*     | *none*    | The field to sort results by. Can be `id`, `name`, with value `asc` or `desc`
`fields`                         | `string`    | *no*     | `all` | Comma separated list of attributes to return.
`include`                        | `string`    | *no*     | ` `  | Relationships to include.
`images[list][image]`            | `object`    | *no*     | ` `  | Customize the image (resize, etc). See *Topics* for details.

## Create event list

<div class="api-endpoint">
	<div class="endpoint-data">
		<i class="label label-post">POST</i>
		<h6>/events/{event-id}/lists</h6>
	</div>
</div>

> Create event list

```shell
curl -X POST \
  https://app.guestmanager.com/api/public/v2/events/71339/lists \
  -H 'Accept: application/json' \
  -H 'Authorization: Token abcdefg' \
  -H 'content-type: multipart/form-data; boundary=----WebKitFormBoundary7MA4YWxkTrZu0gW' \
  -F 'list[image]=@/path/to/file/image.png' \
  -F 'list[name]=New list' \
  -F 'list[description]=blah blah'
```

> Response

```json
{
    "id": 1018378,
    "name": "New list",
    "description": "blah blah",
    "slug": "new-list-5839e45b-27ee-49f4-9de6-85d285b75191",
    "status": "visible",
    "permanent_list_id": null,
    "image": {
        "original": "https://app.guestmanager.com/....png"
    },
    "permanent_list": null,
    "setting": {
        "description": "<p>...</p>",
        "image": {
            "original": "https://app.guestmanager.com/...jpg"
        }
    }
}
```


### Request parameters

Parameter                        | Type          | Required  | Description
-------------------------------- | ------------- | --------- | -----------
`list[name]`                     | `string`      | *yes*     | Name of the list.
`list[image]`                    | `multipart`   | *no*      | If providing an image, the API request must be in multipart. Only submit JPG images, or non-interlaced PNGs.
`list[description]`              | `string`      | *no*      | Describe the list. This content can be dynamically inserted onto a ticket.

* Don't forget to set the multipart boundary in the `content-type` header. More info: <https://stackoverflow.com/questions/3508338/what-is-the-boundary-in-multipart-form-data/20321259#20321259>
* How to send multi-part requests with Postman: <https://stackoverflow.com/questions/16015548/tool-for-sending-multipart-form-data-request>

## Update event list

<div class="api-endpoint">
	<div class="endpoint-data">
		<i class="label label-patch">PATCH</i>
		<h6>/events/{event-id}/lists/{id}</h6>
	</div>
</div>

> Update event list

```shell
curl -X PATCH \
  https://app.guestmanager.com/api/public/v2/events/71339/lists/1018382 \
  -H 'Accept: application/json' \
  -H 'Authorization: Token abcdef' \
  -H 'Content-Type: application/json' \
  -d '{
	"list": {
		"name": "new name"
	}
}'
```

### Request parameters

See parameters for creating a list.