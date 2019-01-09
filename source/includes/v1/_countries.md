# Countries

See [**Objects**](#objects-country) section for details on the fields and relationships.


## List countries
If you need to create address forms in your UI, it is recommended to use our maintained list of country data and `ids`.

<div class="api-endpoint">
	<div class="endpoint-data">
		<i class="label label-get">GET</i>
		<h6>/countries</h6>
	</div>
</div>

This endpoint is not paginated.

> List countries

```shell
curl -X GET \
  https://app.guestmanager.com/api/public/v2/countries \
  -H 'Authorization: Token abcdefg' \
  -H 'Content-Type: application/json' \
```

> Response

```json
[
    {
        "id": 3,
        "name": "Afghanistan",
        "code": "AF",
        "phone_prefix": "93",
        "currency_code": "AFN"
    },
    {
        "id": 6,
        "name": "Albania",
        "code": "AL",
        "phone_prefix": "355",
        "currency_code": "ALL"
    },
    ...
]
```

## List country states

See [**Objects**](#objects-state) section for details on the fields and relationships.


<div class="api-endpoint">
	<div class="endpoint-data">
		<i class="label label-get">GET</i>
		<h6>/countries/{country-id}/states</h6>
	</div>
</div>

This endpoint is not paginated.

> List states (for USA)

```shell
curl -X GET \
  https://app.guestmanager.com/api/public/v2/countries/234/states \
  -H 'Authorization: Token abcdefg' \
  -H 'Content-Type: application/json' \
```

> Response

```json
[
    {
        "id": 4122,
        "name": "Alabama",
        "country_id": 234,
        "code": "AL"
    },
    {
        "id": 4121,
        "name": "Alaska",
        "country_id": 234,
        "code": "AK"
    },
    ...
]
```