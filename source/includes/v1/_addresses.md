# Addresses

Attribute                      | Type     | Description
------------------------------ | -------- | -----------
`address1`                     | string   | Line 1.
`address2`                     | string   | Line 2.
`city`                         | string   | City
`zipcode`                      | string   | Zip code / postal code.
`state_id`                     | integer  | ID of state.
`country_id`                   | integer  | ID of country.
`state`                        | object   | `State`
`country`                      | object   | `Country`

## States

Attribute                      | Type     | Description
------------------------------ | -------- | -----------
`name`                         | string   | Name of the state.
`abbr`                         | string   | Abbreviation of the state name.
`country_id`                   | integer  | The country this state is in.


## Countries

Attribute                      | Type     | Description
------------------------------ | -------- | -----------
`name`                         | string   | Name of the country.
`code`                         | string   | ISO code of the country.
`currency_code`                | string   | Currency ISO code.
`phone_prefix`                 | string   | Phone prefix.