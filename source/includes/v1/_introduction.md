# Introduction

## Base URL
`https://guestmanager.com/api/public/v1`

## Versioning
The version is specified in the request URL. If the version is omitted, the latest version will be used by default.

## Requests

### Headers
The following headers must be specified in all API requests.

Header               | Value
-------------------- | -----------
`Authorization`      | `Token abcdefg`
`Content-Type`       | `application/json`
`Accept`             | `application/json`

### Parameters
All parameters should be submitted as JSON, however url-encoded data is also suitable. Provide only the attributes that you wish to change - do not submit the entire object, as you will likely encounter an error due to read-only attributes.

## Responses
All responses are returned as JSON, along with a relevant status code.

You may change how results are returned by specifying an `adapter` in the `GET` request.

`adapter`       | Description
--------------- | -----------------
`attributes`    | Default. Array of objects, with no top-level key.
`json`*         | Array of objects, with a top-level key, and pagination information.
`json_api`**    | Conforms to the JSON API spec.

- * Alpha.
- ** Super Duper Alpha.

### Successful Status Codes
Code                 | Description
-------------------- | -----------
`200`                | OK
`201`                | Created
`204`                | No Content -- used for `DELETE` requests.