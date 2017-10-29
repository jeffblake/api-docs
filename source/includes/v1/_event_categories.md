# Event Categories
An event can have many categories.

Attribute                      | Type     | Description
------------------------------ | -------- | -----------
`name`                         | string   | Name of the category.
`description`                  | text     | Description.
`subtitle`                     | string   | Subtitle.
`position`                     | integer  | Sorting.
`short_description`            | text     | Shorter description.
`icon_url`                     | string   | URL for the icon image.
`children`                     | array    | Sub-categories.


<div class="api-endpoint">
	<div class="endpoint-data">
		<i class="label label-get">GET</i>
		<h6>/categories</h6>
	</div>
</div>

## Request Parameters

Attribute                      | Type     | Values
------------------------------ | -------- | -----------
`sort_by`                      | string   | `name`, `position`

