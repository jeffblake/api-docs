# Venues

Attribute                      | Type     | Description
------------------------------ | -------- | -----------
`name`                         | string   | Name of the venue.
`description`                  | text     | Additional line can be used to describe the venue.
`slug`                         | string   | Auto-generated for use in url-generation.
`time_zone`                    | string   | Time zone where the venue is located.
`latitude`                     | string   | Latitude of venue. Used for Apple Wallet.
`longitude`                    | string   | Longitude of venue. Used for Apple Wallet.
`address_id`                   | integer  | ID of the associated address.
`address`                      | object   | Address of the venue. See `Address`.


<div class="api-endpoint">
	<div class="endpoint-data">
		<i class="label label-get">GET</i>
		<h6>/venues</h6>
	</div>
</div>