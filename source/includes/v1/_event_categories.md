# Event categories
An event can have many categories.
See [**Objects**](#objects-category) section for details on the fields and relationships.


## List categories

<div class="api-endpoint">
	<div class="endpoint-data">
		<i class="label label-get">GET</i>
		<h6>/categories</h6>
	</div>
</div>

> List categories

```shell
curl -X GET \
  https://app.guestmanager.com/api/public/v2/categories \
  -H 'Authorization: Token abcdefg' \
  -H 'Content-Type: application/json' \
```

> Response

```json
{
    "data": [
        {
            "id": 18,
            "name": "MasterClasses",
            "subtitle": null,
            "position": 3,
            "short_description": null,
            "description": null,
            "image": {
                "original": "../image.png"
            }
        },
        {
            "id": 3,
            "name": "Complimentary Owner Product Demonstrations",
            "subtitle": "Master Your Miele",
            "position": 2,
            "short_description": "text",
            "description": "HTML description",
            "image": null
        }
    ],
    "meta": {
        "count": 3,
        "total": 3,
        "page": {
            "number": 1,
            "size": 10,
            "next": null,
            "prev": null,
            "total": 1,
            "last": true,
            "first": true,
            "out_of_range": false
        },
        "links": {
            "self": "https://app.guestmanager.com/api/public/v2/categories",
            "next": null,
            "prev": null,
            "first": "https://app.guestmanager.com/api/public/v2/categories?page%5Bnumber%5D=1",
            "last": "https://app.guestmanager.com/api/public/v2/categories?page%5Bnumber%5D=1"
        }
    }
}
```

> List categories with image resized

```shell
curl -X GET \
  https://app.guestmanager.com/api/public/v2/categories \
  -H 'Authorization: Token abcdefg' \
  -H 'Content-Type: application/json' \
  -d '{
	"images": {
		"category": {
			"image": [
				{
					"key": "thumbnail",
					"options": {
						"resize": "250x250>"
					}
				}
			]
		}
	}
}'
```

> Response (details omitted for brevity)

```json
{
    "data": [
        {
            "id": 18,
            "name": "MasterClasses",
            "subtitle": null,
            "position": 3,
            "short_description": null,
            "description": null,
            "image": {
                "original": "https://app.guestmanager.com/rails/active_storage/blobs/eyJfcmFpbHMiOnsibWVzc2FnZSI6IkJBaHBBdndEIiwiZXhwIjpudWxsLCJwdXIiOiJibG9iX2lkIn19--529b75c541f8b17666f9c0ec4510720254d824a3/event_portrait.png",
                "thumbnail": "https://app.guestmanager.com/rails/active_storage/representations/eyJfcmFpbHMiOnsibWVzc2FnZSI6IkJBaHBBdndEIiwiZXhwIjpudWxsLCJwdXIiOiJibG9iX2lkIn19--529b75c541f8b17666f9c0ec4510720254d824a3/eyJfcmFpbHMiOnsibWVzc2FnZSI6IkJBaHZPaUZCWTNScGIyNURiMjUwY205c2JHVnlPanBRWVhKaGJXVjBaWEp6QnpvUVFIQmhjbUZ0WlhSbGNuTkRPaTFCWTNScGRtVlRkWEJ3YjNKME9qcElZWE5vVjJsMGFFbHVaR2xtWm1WeVpXNTBRV05qWlhOemV3WkpJZ3R5WlhOcGVtVUdPZ1pGUmtraURUSTFNSGd5TlRBK0Jqc0lWRG9QUUhCbGNtMXBkSFJsWkZRPSIsImV4cCI6bnVsbCwicHVyIjoidmFyaWF0aW9uIn19--97d9c524c32e1915e2f7cbf4eceb89a17ca810fc/event_portrait.png"
            }
        }
    ],
    "meta": ...
}
```

### Request parameters

Parameter                            | Type       | Required | Default   | Description
------------------------------------ | ---------- | -------- | --------- | --------------
`page[size]`                         | `integer`  | *no*     | `10`      | How many records to return per request. Default is `10`, maximum is `100`
`page[number]`                       | `integer`  | *no*     | `1`       | The page of records to request.
`sort[{field}]`                      | `object`   | *no*     |           | Replace `{field}` with one of `position`, with value of `asc` or `desc`
`images[category][image]`            | `array`    | *no*     |           | Request custom sized images. See *Topics* for details.

