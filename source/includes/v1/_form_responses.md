# Responses

## Response properties

> Example Response

```json
{
	"id": 38133,
	"form_id": 3591,
	"answers": [{
			"id": 167286,
			"form_field_id": 10661,
			"value": "592",
			"human_value": "Miele Centre Staff",
			"field": {
				"id": 10661,
				"label": "How did you find out about the demonstration?",
				"required": true,
				"enabled": true,
				"help_text": "",
				"type": "multiple_choice",
				"options": [{
						"id": 592,
						"form_field_id": 10661,
						"name": "Miele Centre Staff",
						"value": "",
						"type": null,
						"position": 1
					},
					{
						"id": 594,
						"form_field_id": 10661,
						"name": "Newspaper Ad",
						"value": "",
						"type": null,
						"position": 3
					},
					{
						"id": 790,
						"form_field_id": 10661,
						"name": "Friend Referral",
						"value": "",
						"type": null,
						"position": 7
					}
				]
			}
		},
		{
			"id": 167287,
			"form_field_id": 10655,
			"value": "test",
			"human_value": "test",
			"field": {
				"id": 10655,
				"label": "When did you buy your appliance?",
				"required": true,
				"enabled": true,
				"help_text": "",
				"type": "text_field",
				"options": []
			}
		},
		{
			"id": 167288,
			"form_field_id": 10654,
			"value": "791",
			"human_value": "Other (list below)",
			"field": {
				"id": 10654,
				"label": "Which Miele appliance do you own?",
				"required": true,
				"enabled": true,
				"help_text": "",
				"type": "multiple_choice",
				"options": [{
						"id": 791,
						"form_field_id": 10654,
						"name": "Other (list below)",
						"value": "",
						"type": null,
						"position": 98
					},
					{
						"id": 792,
						"form_field_id": 10654,
						"name": "My appliance isn't listed here",
						"value": "",
						"type": null,
						"position": 99
					},
					{
						"id": 529,
						"form_field_id": 10654,
						"name": "H 2661 B CleanSteel 60cm wide oven",
						"value": "",
						"type": null,
						"position": null
					}
				]
			}
		},
		{
			"id": 167289,
			"form_field_id": 10775,
			"value": null,
			"human_value": null,
			"field": {
				"id": 10775,
				"label": "Other",
				"required": false,
				"enabled": true,
				"help_text": "",
				"type": "text_field",
				"options": []
			}
		}
	]
}
```

Attribute                         | Type     | Description
--------------------------------- | -------- | -----------
`form_id`                         | integer  | The referenced `Form` <i class="label label-info">read-only</i>
`answers`                         | array    | Individual answers contained in this response.

### Answer attributes

Attribute                         | Type            | Description
--------------------------------- | --------------- | -----------
`form_field_id`                   | integer         | The question being answered. <i class="label label-info">read-only</i>
`value`                           | string|array    | The actual answer. For `multiple_choice` questions, this is the `option.id`
`human_value`                     | string          | If `multiple_choice`, the name of the option. <i class="label label-info">read-only</i>
`field`                           | object          | The question. <i class="label label-info">read-only</i>

### Field attributes

Attribute                         | Type     | Description
--------------------------------- | -------- | -----------
`type`                            | string   | The kind of question being asked. `text_field`, `multiple_choice`
`label`                           | string   | Question being asked.
`required`                        | boolean  |
`enabled`                         | boolean  |
`help_text`                       | string   | Additional information about the question.
`options`                         | array    | If `type` is `multiple_choice`, these are the possible answers.

### Option attributes

Attribute                         | Type     | Description
--------------------------------- | -------- | -----------
`form_field_id`                   | integer  | The kind of question being asked. `text_field`, `multiple_choice`
`name`                            | string   | The option value/name.
`position`                        | integer  | How to sort the option.