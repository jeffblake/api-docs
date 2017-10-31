# Addresses

## Address properties

Attribute                      | Type     | Description
------------------------------ | -------- | -----------
`address1`                     | string   | Line 1.
`address2`                     | string   | Line 2.
`city`                         | string   | City
`zipcode`                      | string   | Zip code / postal code.
`state_name`                   | string   | Name of the State.
`state_code`                   | string   | Abbreviation of the State.
`country_name`                 | string   | Name of the country.
`country_code`                 | string   | ISO code of the Country.
`state_id`                     | integer  | ID of state.
`country_id`                   | integer  | ID of country.
`state`                        | object   | `State`
`country`                      | object   | `Country`

## State properties

Attribute                      | Type     | Description
------------------------------ | -------- | -----------
`name`                         | string   | Name of the state.
`code`                         | string   | Abbreviation of the state name.
`country_id`                   | integer  | The country this state is in.


## Country properties

Attribute                      | Type     | Description
------------------------------ | -------- | -----------
`name`                         | string   | Name of the country.
`code`                         | string   | ISO code of the country.
`currency_code`                | string   | Currency ISO code.
`phone_prefix`                 | string   | Phone prefix.


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