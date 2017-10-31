# Topics

## Authentication

Authentication is done through the `Authorization` request header. The value should be in the format `Token abcdefg` where `abcdefg` is replaced with your API Key.

```shell
### Request Header
curl "http://guestmanager.com/api/pubic/v1"
  -H "Authorization: Token meowmeowmeow"
```

### API keys
API Keys are created in the company dashboard under the Config menu. API keys are authorized for either `read`, `write`, or both.

### API key permissions
API Keys are authorized for `read`, `write`, or both.

Attribute                 | Request methods
------------------------- | -----------------
`read`                    | `GET`
`write`                   | `POST`, `PATCH`, `DELETE`


## Common attributes
All resources have the following attributes.

Attribute                      | Type     | Description
------------------------------ | -------- | -----------
`id`                           | integer  | Unique identifier for the resource. <i class="label label-info">read-only</i>
`created_at`                   | datetime | When the record was created. <i class="label label-info">read-only</i>
`updated_at`                   | datetime | When the record was last updated. <i class="label label-info">read-only</i>
`deleted_at`                   | datetime | When the record was deleted. <i class="label label-info">read-only</i>


## Data types

Type              | Example                           | Description
----------------- | --------------------------------  | ----------------------------------
`datetime`        | `"2017-10-25T17:54:51.557604Z"`   | `iso8601` format in the UTC time zone.
`decimal`         | `102.56`                          | All monetary amounts are returned as a `string` to two decimal places.

## Filters

Parameter      | Format                                        | Example
-------------- | ----------------------------------------      | ----------------------------------
`ids`          | Comma separated string or JSON array.         | `"1,2,3"` or ```json {"ids": [1,2,3]}```

## Pagination
For resource collection endpoints, the following parameters can be used to paginate responses.

Parameter           | Default            | Description
-------------- | -----------------  | ----------------------------------
`per_page`     | `10`               | How many records to return in each response.
`page`         | `1`                | The page to return records for.


## Fields and relationships
To increase performance and optimize network traffic, you may specify only the fields and relationships you interested in.
Refer to a specific resource endpoint to see which fields and relationships are available.

Parameter      | Options
-------------- | -----------------
`fields`       | Comma separated string of the attributes you are interested in for that particular model.
`includes`     | Comma separated string of the relationships you are interested in for that particular model.

## Sorting
For resource collection endpoints, you can sort by the following common attributes, or any resource-specific attribute (e.g. `start_date` for `Event`)

Parameter      | Options
-------------- | -----------------
`sort_dir`     | `asc` or `desc`
`sort_by`      | `id`, `created_at`, `updated_at`, or any resource specific attribute.