# Recurring events
Top level non-bookable events that serve as the wrapper around individual event date/times. The ID of the class can be used to query against the Events API to return date/times for that series.

##  Properties

Attribute                      | Type     | Description
------------------------------ | -------- | -----------
`name`                         | string   | Name of the series.
`position`                     | integer  | Sorting.
`calendar_id`                  | integer  | Calendar this series belongs to.
`categories`                   | array    | Categories associated to this series.
`tags`                         | array    | Tags associated to this series.

## List recurring events

<div class="api-endpoint">
	<div class="endpoint-data">
		<i class="label label-get">GET</i>
		<h6>/series</h6>
	</div>
</div>

### Request

Attribute                      | Type     | Default   | Values
------------------------------ | -------- | --------- | ----------
`include`                      | string   | *none*    | `tags`, `categories`
`published_at`                 | string   | *none*    | `published`, `unpublished`

