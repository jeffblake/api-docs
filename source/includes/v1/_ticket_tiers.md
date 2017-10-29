# Ticket Tiers

## Attributes

Attribute                      | Type     | Description
------------------------------ | -------- | -----------
`event_id`                     | integer  | Event this tier belongs to.
`parent_tier_id`               | integer  | Parent `TicketTier`
`product_id`                   | integer  | `Product` this tier belongs to.
`ticket_type`                  | object   | `TicketType` this tier belongs to.
`price_levels`                 | array    | Array of `TicketTierLevel`


## Ticket Tier Level Attributes

Attribute                      | Type     | Description
------------------------------ | -------- | -----------
`name`                         | string   | Name.
`ticket_tier_id`               | integer  | `TicketTier`
`variant_id`                   | integer  | ID of the related product - used to create `LineItem`'s
`price`                        | decimal  | The variant's price.
`currency`                     | string   | The variant's currency.
`status`                       | string   | Current selling status of the variant.
`count_on_hand`                | integer  | How many are in-stock.
`variant`                      | object   | The related variant.