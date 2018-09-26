# Events

## Event properties

Attribute                      | Type     | Description
------------------------------ | -------- | -----------
`name`                         | string   | Name of the series.
`slug`                         | string   |
`venue_id`                     | integer  |
`parent_event_id`              | integer  | The series this event belongs to.
`published_at`                 | datetime | When the event was published.
`position`                     | integer  | Sorting.
`calendar_id`                  | integer  | Calendar this event belongs to.
`categories`                   | array    | Categories associated to this event.
`links`                        | object   | `manage`, `event_page`, `order_page`
`start`                        | object   | `tz`, `local`, `utc`
`end`                          | object   |
`running`                      | boolean  |
`past`                         | boolean  |
`future`                       | boolean  |
`selling`                      | boolean  |
`graphics`                     | object   | `banner`, `background`
`venue`                        | object   |
`tags`                         | array    |
`ticket_tiers`                 | array    |


## Start and end attributes
For convenience, `start` and `end` are provided as objects, each containing `tz`, `local`, and a `utc` attribute.

```json
{
  "tz": "Melbourne",
  "local": "2016-10-31T11:00:00+11:00",
  "utc": "2016-10-31T00:00:00Z"
}
```

Attribute                      | Type     | Description
------------------------------ | -------- | -----------
`tz`                           | string   | Venue time zone.
`local`                        | string   | `datetime` in the venue time zone.
`utc`                          | string   | `datetime` in UTC (global) format.


## List events

<div class="api-endpoint">
	<div class="endpoint-data">
		<i class="label label-get">GET</i>
		<h6>/events</h6>
	</div>
</div>

### Request parameters

Attribute                      | Type     | Default   | Values
------------------------------ | -------- | --------- | ----------
`fields`                       | string   | *none*    | `links`
`sort_by`                      | string   | *none*    | `start_date`, `end_date`, `name`, `parent_event_id`, `venue_id`, `published_at`, `position`
`include`                      | string   | *none*    | `tags`, `categories`, `ticket_tiers`, `ticket_tiers.price_levels`, `venue`, `venue.address`
`venue_id`                     | integer  | *none*    | Filter by a specific venue.
`parent_event_id`              | integer  | *none*    | Filter by event series.
`category_id`                  | integer  | *none*    | Filter by category.
`status`                       | string   | *none*    | `active`: events in progress and future events<br>`over`: events where `end_date < current time`<br>`future`: events with start dates in the future (excludes active events)<br>`past`: events where start_date is less than current time<br>`this_week`: Monday-Sunday<br>`next_week`: Next Monday-Sunday
`published`                    | boolean  | *none*    | `true` or `false`
`name`                         | string   | *none*    | Runs a case insensitive query to match any events containing this query. Only use for user-generated searching as this is slower, and querying attributes directly (like parent_event_id and venue_id) is going to be much more reliable.
`start_date[range_start]`      | date or datetime | *none* | Beginning start date range.
`start_date[range_end]`        | date or datetime | *none* | Ending start date range.
`end_date[range_start]`        | date or datetime | *none* | Beginning end date range.
`end_date[range_end]`          | date or datetime | *none* | Ending end date range.

## Fetch event

<div class="api-endpoint">
	<div class="endpoint-data">
		<i class="label label-get">GET</i>
		<h6>/events/{id}</h6>
	</div>
</div>

## Create event

<div class="api-endpoint">
	<div class="endpoint-data">
		<i class="label label-post">POST</i>
		<h6>/events</h6>
	</div>
</div>

### Request parameters

Attribute                      | Type     | Required   | Description
------------------------------ | -------- | --------- | ----------
`event[name]`                  | `string`   | *yes*    | Name of the event.
`event[venue_id]`              | `integer`   | *yes*    | `id` of the venue. Please find or create a venue first.
`event[start_date]`            | `datetime`   | *yes*    | Start date and time of the event.
`event[end_date]`              | `datetime`  | *yes*    | End date and time of the event.

## Fetch ticket tiers
Returns the bookable items for an event.

Each Tier has at least one Price Level. The variant_id in the price_levels array is important, because it’s used to create an Order.

<div class="api-endpoint">
	<div class="endpoint-data">
		<i class="label label-get">GET</i>
		<h6>/events/{id}/ticket_tiers</h6>
	</div>
</div>

### Request parameters

Attribute                      | Type     | Default           | Values
------------------------------ | -------- | ----------------- | ----------
`{id}`                         | integer  | *required*        | Event ID.
`include`                      | string   | `price_levels`    | `price_levels`
