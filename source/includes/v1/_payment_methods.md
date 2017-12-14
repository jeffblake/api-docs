# Payment Methods

## Payment method properties

Attribute                    | Type    | Description
---------------------------- | ------- | -----------
`type`                       | string  |
`name`                       | string  |
`description`                | string  |
`display_name`               | string  |
`currencies`                 | array   | A list of currencies this payment method supports.
`billing_address_required`   | boolean |
`payment_profiles_enabled`   | boolean |
`test_mode`                  | boolean |
`active`                     | boolean |
`tokenize_key`               | string  | If the gateway supports credit card tokenization, use this key to generate a token clientside before submitting to the API.