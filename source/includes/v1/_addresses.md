# Addresses

## Address properties

For convenience, you can provide either `country_code` and `state_code` in place of `country_id` and `state_id`

Attribute                      | Type     | Description
------------------------------ | -------- | -----------
`address1`                     | string   | Line 1.
`address2`                     | string   | Line 2.
`city`                         | string   | City
`zipcode`                      | string   | Zip code / postal code.
`state_name`                   | string <i class="label label-info">read-only</i>   | Name of the State.
`state_code`                   | string   | Abbreviation of the State.
`country_name`                 | string <i class="label label-info">read-only</i>   | Name of the country.
`country_code`                 | string   | ISO code of the Country.
`state_id`                     | integer  | ID of state.
`country_id`                   | integer  | ID of country.
`state`                        | object <i class="label label-info">read-only</i>  | `State`
`country`                      | object <i class="label label-info">read-only</i>   | `Country`

## State properties

Attribute                      | Type     | Description
------------------------------ | -------- | -----------
`name`                         | string <i class="label label-info">read-only</i>   | Name of the state.
`code`                         | string <i class="label label-info">read-only</i>   | Abbreviation of the state name.
`country_id`                   | integer <i class="label label-info">read-only</i>  | The country this state is in.


## Country properties

Attribute                      | Type     | Description
------------------------------ | -------- | -----------
`name`                         | string <i class="label label-info">read-only</i>   | Name of the country.
`code`                         | string <i class="label label-info">read-only</i>   | ISO code of the country.
`currency_code`                | string <i class="label label-info">read-only</i>   | Currency ISO code.
`phone_prefix`                 | string <i class="label label-info">read-only</i>   | Phone prefix.


## List countries
If you need to create address forms in your UI, it is recommended to use our maintained list of country data and `ids`.

<div class="api-endpoint">
	<div class="endpoint-data">
		<i class="label label-get">GET</i>
		<h6>/countries</h6>
	</div>
</div>

## List country states

<div class="api-endpoint">
	<div class="endpoint-data">
		<i class="label label-get">GET</i>
		<h6>/countries/{country-id}/states</h6>
	</div>
</div>