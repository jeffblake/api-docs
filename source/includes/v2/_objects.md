# Objects

## Common fields

Field                         | Type           | Description
----------------------------- | -------------- | -----------
`id`                          | `int`          | Unique identifier. <i class="label label-info">read-only</i>
`created_at`                  | `datetime`     | When this object was created. <i class="label label-info">read-only</i>
`updated_at`                  | `datetime`     | When this object was last updated. <i class="label label-info">read-only</i>


## Data types

> `money` data type

```json
{
    "decimal": "53.5",
    "amount": 5350, // Integer
    "formatted": "$53.50" // Includes appropriate currency symbol
}
```

Type              | Example                           | Description
----------------- | --------------------------------  | ----------------------------------
`date`            | `2018-05-25`                      | `yyyy-mm-dd`
`datetime`        | `"2017-10-25T17:54:51.557604Z"`   | `iso8601` format in the UTC time zone.
`decimal`         | `102.56`                          | Decimals are provided as a string.
`image`           | `{ "original": "...com/image.jpg" }`                          | Images are put into an object. Additional keys can be added dynamically for altering images. Refer to *Topics* on how to achieve this.
`money`           | `{ "decimal": "10.0", "amount": 1000, "formatted": "$10.00" }`              | A `money` attribute is an object that includes a few different representations of the amount, mostly for convenience.


## Email

> Email object

```json
  {
      "id": 894675,
      "created_at": "2018-06-04T16:48:50.245304Z",
      "updated_at": "2018-06-04T17:04:26.582437Z",
      "type": "ticket_email",
      "email": "*****@gmail.com",
      "state": "delivered",
      "status": "opened",
      "delivery_error_detail": null,
      "click_count": 0,
      "open_count": 3,
      "subject": "Your Ticket attached!",
      "body": null
  }
```

Field                     | Type         | Description
------------------------- | ------------ | -----------
`email`                   | `string`     | Email address this email was sent to. <i class="label label-info">read-only</i>
`type`                    | `string`     | The type of email that was sent. <i class="label label-info">read-only</i>
`state`                   | `string`     | Delivery status. See below for descriptions. <i class="label label-info">read-only</i>
`status`                  | `string`     | How the recipient responded to the email. See below for descriptions. <i class="label label-info">read-only</i>
`delivery_error_detail`   | `string`     | If the `state` is not `delivered`, you may inspect this field to see why. <i class="label label-info">read-only</i>
`open_count`              | `int`        | How many times the email was opened. <i class="label label-info">read-only</i>
`click_count`             | `int`        | How many times a link was clicked in the email. <i class="label label-info">read-only</i>
`subject`                 | `string`     | The email subject. <i class="label label-info">read-only</i>
`body`                    | `string`     | The HTML body of the email. This field will be `null` after approximately 6 months. <i class="label label-info">read-only</i>

### Email `type`

Type              | Description
----------------- | --------------
`ticket_email`    | Ticket was sent to the guest, either as a PDF attachment or a downloadable link, depending on your configuration.

### Email `state`

State           | Successful?     | Description
--------------- | --------------- | --------------
`draft`         | No              | Email has been queued for delivery.
`delivering`    | No              | Email is currently being sent.
`delivered`     | Yes             | Email was sent successfully.
`bounced`       | No              | Bounce. See `delivery_error_detail` for more information.
`dropped`       | No              | Email was canceled due to previously known issue with this email address.
`canceled`      | No              | Email was canceled due to condition that made this email no longer relevant. e.g. the ticket was deleted.

### Email `status`

State             | Description
----------------- | --------------
`unopened`        | Email has not been opened yet.
`opened`          | Email was opened.
`clicked`         | Recipient clicked a link in the email.
`spammed`         | Recipient reported this email as spam.
`unsubscribed`    | Recipient unsubscribed.


## Event

> Event object

```json
{
    "id": 59978,
    "name": "Gourmet Steam Oven",
    "slug": "gourmet-steam-oven-10-30am-12-00pm",
    "status": "past",
    "venue_id": 1989,
    "parent_event_id": 59918,
    "calendar_id": 7,
    "published_at": "2016-10-17T01:08:42.038414Z",
    "start": {
        "tz": "Melbourne",
        "local": "2016-10-28T10:30:00+11:00",
        "utc": "2016-10-27T23:30:00Z"
    },
    "end": {
        "tz": "Melbourne",
        "local": "2016-10-28T12:00:00+11:00",
        "utc": "2016-10-28T01:00:00Z"
    },
    "venue": {
        "id": 1989,
        "name": "South Melbourne",
        "description": null,
        "slug": "south-melbourne"
    },
    "tags": [
        {
            "id": 297,
            "name": "demonstration"
        },
        {
            "id": 298,
            "name": "how to"
        }
    ],
    "registration_types": [
        {
            "id": 24,
            "variant_id": 1867,
            "name": "Free registration",
            "description": null,
            "stock_item": {
                "id": 17066,
                "status": "not_on_sale",
                "available": 0
            },
            "prices": [
                {
                    "decimal": "0.0",
                    "amount": 0,
                    "currency": "AUD",
                    "default": true,
                    "formatted": "$0.00"
                }
            ]
        }
    ],
    "list": {
        "id": 936655,
        "name": "Miele Australia",
        "slug": "miele-australia",
        "status": "visible",
        "permanent_list_id": 26281,
        "image": null,
        "permanent_list": {
            "id": 26281,
            "name": "Miele Australia",
            "slug": "miele-australia",
            "recurring": true,
            "status": "visible"
        },
        "setting": {
            "description": "<p>The wonders of cooking with a Miele Steam Oven await you! This relaxed, fun and informative demonstration will give you the confidence and inspiration to really get the best out of your investment.&nbsp;Watch as our experts bring to life recipes utilising the steam oven’s innovative cooking methods, learning the best ways this appliance can complement your cooking style.&nbsp;As you sit down to taste the delectable results, you’ll have all your questions answered in an intimate environment.</p>",
            "image": {
                "original": "http://app.guestmanager.com/rails/active_storage/blobs/eyJfcmFpbHMiOnsibWVzc2FnZSI6IkJBaHBBaFVOIiwiZXhwIjpudWxsLCJwdXIiOiJibG9iX2lkIn19--2e1025ef197bc7aff81eacd3f43b3fc41d2b2a84/Gourmet_Steam_Oven2.jpg"
            }
        }
    }
}
```

Attribute                      | Type       | Description
------------------------------ | ---------- | -----------
`name`                         | `string`   | Event name.
`status`                       | `string`   | One of `past`, `in_progress`, `future`. See below for descriptions. <i class="label label-info">read-only</i>
`slug`                         | `string`   | URL parameter for the event page.
`venue_id`                     | `integer`  |
`parent_event_id`              | `integer`  | The recurring event this event belongs to. <i class="label label-info">read-only</i>
`published_at`                 | `datetime` | When the event was published.
`position`                     | `integer`  | Sorting.
`calendar_id`                  | `integer`  | Calendar this event belongs to.
`start`                        | `object`   | `tz`, `local`, `utc` <i class="label label-info">read-only</i>
`end`                          | `object`   | <i class="label label-info">read-only</i>

### Event `status`

Status                         | Description
------------------------------ | --------------------
`past`                         | Event is over (The current time is greater than `ends_at`)
`in_progress`                  | Event is currently running (The current time is between `starts_at` and `ends_at`)
`future`                       | Event has not started yet (The current time is less than `starts_at`)


### Event relationships
These are not included by default. To request them, add a `include` query parameter. You may include multiple relationships by comma separating them.

Key                            | Relationship        | Type
------------------------------ | ------------------- | -----------
`list`                         | `EventList`         | `object`
`company`                      | `Company`           | `object`
`venue`                        | `Venue`             | `object`
`categories`                   | `Category`          | `array`
`registration_types`           | `RegistrationType`  | `array`
`tags`                         | `Tag`               | `array`



### Start and end attributes
For convenience, `start` and `end` are provided as objects, each containing `tz`, `local`, and a `utc` attribute.

Attribute                      | Type     | Description
------------------------------ | -------- | -----------
`tz`                           | string   | Venue time zone.
`local`                        | string   | `datetime` in the venue time zone.
`utc`                          | string   | `datetime` in UTC (global) format.

##  Recurring event

> Recurring event object

```json
{
    "id": 69956,
    "name": "Girls' Night In",
    "slug": "girls-night-in",
    "calendar_id": null,
    "position": 1,
    "categories": [
        {
            "id": 2,
            "name": "Complimentary Discovery Product Demonstrations",
            "subtitle": "Discover Miele",
            "position": 1,
            "short_description": "Receive expert advice to simplify your decision making process, enabling you to select the right products to empower your lifestyle",
            "description": "<p>Combining elegant new design with outstanding innovations, including ovens with smart phone style swipe or scroll touchscreens, Miele appliances are user friendly and take speed and efficiency to a whole new level – along with your cooking skills. These extraordinary appliances have so many revolutionary features and benefits, only a hands-on experience can do them justice.</p><p>Our Introductory Demonstrations are designed to allow you to sit down and relax in an intimate group as our Home Economist shows you how these ovens will transform the way you cook. We then invite you to taste the quality and range of dishes they so effortlessly produce. &nbsp;Each dish you see prepared will bring to life a feature of these amazing appliances. You’ll have all your questions answered, receive a generous helping of expert advice and leave with a selection of exclusive Miele recipes and all the inspiration you need to try them for yourself!</p><p>Please note: Cooking class attendees must be over 14 years of age.</p>",
            "image": {
                "original": "http://app.guestmanager.com/rails/active_storage/blobs/eyJfcmFpbHMiOnsibWVzc2FnZSI6IkJBaHBBdmtEIiwiZXhwIjpudWxsLCJwdXIiOiJibG9iX2lkIn19--a2e3b3e87ee9c449cb394119e8ce14edc57e90c0/Miele-Deb-Hutton-0417-exp.jpg"
            }
        }
    ],
    "tags": []
}
```

Field                          | Type       | Description
------------------------------ | ---------- | -----------
`name`                         | `string`   | Name of the series.
`position`                     | `integer`  | Sorting.
`calendar_id`                  | `integer`  | Calendar this series belongs to.
`categories`                   | `array`    | Categories associated to this series.
`tags`                         | `array`    | Tags associated to this series.


## Event list

> Event list object

```json
{
  "id": 936641,
  "name": "Miele Australia",
  "slug": "miele-australia",
  "status": "visible",
  "permanent_list_id": 26281,
  "image": null,
  "links": {
    "event_page": "...",
    "order_page": "..."
  },
  "permanent_list": {
      "id": 26281,
      "name": "Miele Australia",
      "slug": "miele-australia",
      "recurring": true,
      "status": "visible"
  },
  "setting": {
      "description": "<p>This class introduces you to the world of steam, highlighting the nutritional and flavour benefits steam has to offer, while showcasing how this new generation of steam cooking can integrate into your lifestyle. &nbsp;In a comfortable setting which encourages questions, this class will equip you with the knowledge about optimal ways steam can transform the way you cook, and why you should consider this appliance as part of your kitchen design.</p>",
      "image": {
          "original": "http://app.guestmanager.com/rails/active_storage/blobs/eyJfcmFpbHMiOnsibWVzc2FnZSI6IkJBaHBBaFlOIiwiZXhwIjpudWxsLCJwdXIiOiJibG9iX2lkIn19--b0a487cb84b1e6a267e3cf27ec525dfce56d8eb2/Intro_To_Steam_GuestManager2.jpg"
  }
}
```

Attribute                      | Type       | Description
------------------------------ | ---------- | -----------
`name`                         | `string`   | List name.
`slug`                         | `string`   | URL parameter for the event list.
`status`                       | `string`   | One of `visible` or `hidden`
`permanent_list_id`            | `integer`  | The permanent list this event list is a part of. `null` for one-off lists. <i class="label label-info">read-only</i>
`image`                        | `object`   | Image for the list. <i class="label label-info">read-only</i>
`links`                        | `object`   | URLs for the `event_page` and `order_page` <i class="label label-info">read-only</i>


### Event list relationships

Key                      | Relationship         | Type
------------------------ | --------------       | -----------
`permanent_list`         | `PermanentList`      | `object`
`setting`                | `EventListSetting`   | `object`


## Category

> Category object

```json
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
}
```

Field                          | Type       | Description
------------------------------ | ---------- | -----------
`name`                         | `string`   | Name of the category.
`description`                  | `text`     | Description.
`subtitle`                     | `string`   | Subtitle.
`position`                     | `integer`  | Sorting.
`short_description`            | `text`     | Shorter description.
`image`                        | `object`   | Contains URLs for the image. <i class="label label-info">read-only</i>


## Ticket

> Ticket object

```json
{
    "id": 2307131,
    "number": "iZKiKsVLYB6DsSfkzAEGvmAx",
    "status": "redeemed",
    "name": "Joe Jordan",
    "email": "joe.jordan@****.co",
    "barcode_id": "8894042401339101",
    "note": null,
    "event_id": 68718,
    "ticket_type_id": 4329,
    "event_ticket_type_id": 13106,
    "list_id": 990493,
    "source_id": 12345,
    "source_type": "line_item",
    "contact_id": null,
    "dispatched_at": "2018-04-27T21:02:58.705838Z",
    "downloaded_at": null,
    "checkin_at": "2018-05-24T17:23:48.253518Z",
    "contact": null,
    "links": {
        "pdf": "https://client.guestmanager.com/tickets/pMWFB5ysddkNidtoJE7pfCfc.pdf",
        "wallet": null
    },
    "custom_fields": [
        {
            "id": 1605896,
            "field_id": 1504,
            "name": "Company",
            "value": "ACME Inc"
        },
        {
            "id": 1605895,
            "field_id": 1505,
            "name": "Title",
            "value": "Marketing Director"
        }
    ],
    "scans": [
        {
            "id": 606613,
            "data": "8894042401339101",
            "scanned_at": "2018-05-24T17:23:48.248922Z",
            "action": "in",
            "employee_id": 4911,
            "device_id": 3901
        }
    ],
    "emails": [
        {
            "id": 894675,
            "created_at": "2018-06-04T16:48:50.245304Z",
            "updated_at": "2018-06-04T17:04:26.582437Z",
            "type": "ticket_email",
            "email": "*****@gmail.com",
            "state": "delivered",
            "status": "opened",
            "delivery_error_detail": null,
            "click_count": 0,
            "open_count": 3,
            "subject": "Your Ticket attached!",
            "body": null
        }
    ]
}
```

Attribute                     | Type      | Description
----------------------------- | --------- | -----------
`id`                          | `int`     | Unique identifier. <i class="label label-info">read-only</i>
`event_id`                    | `int`     | ID of `Event`
`list_id`                     | `int`     | ID of `List`, the event-specific list. (join table)
`ticket_type_id`              | `int`     | ID of the `TicketType`, a company-wide ticket type.
`event_ticket_type_id`        | `int`     | ID of the event-specific ticket type (join table)
`contact_id`                  | `int`     | ID of the `Contact`, the owner of the ticket.
`source_type`                 | `string`  | One of `line_item` (for Orders), `rsvp`, `invite`, or `null` <i class="label label-info">read-only</i>
`source_id`                   | `int`     | ID of the associated `source_type` <i class="label label-info">read-only</i>
`status`                      | `string`  | Ticket status. See below for descriptions and possible statuses. <i class="label label-info">read-only</i>
`checkin_at`                  | `datetime`| When the ticket was scanned or checked in. <i class="label label-info">read-only</i>
`dispatched_at`               | `datetime`| When the ticket was delivered to the contact (by email) <i class="label label-info">read-only</i>
`downloaded_at`               | `datetime`| When the contact downloaded their ticket. <i class="label label-info">read-only</i>
`barcode_id`                  | `string`  | An event-specific barcode identifier that you can specify to scan the ticket.
`number`                      | `string`  | Globally unique identifier, used to generate barcode and validate ticket (if `barcode_id` not provided). <i class="label label-info">read-only</i>
`name`                        | `string`  | Name on the ticket. Usually `null`, when `contact_id` is provided.
`email`                       | `string`  | Email on the ticket. Usually `null`, when `contact_id` is provided.
`note`                        | `string`  | Note to display to staff at check-in.
`links`                       | `object`  | Download links for PDF and Apple Wallet. PDF: `links.pdf`, Wallet: `links.wallet` <i class="label label-info">read-only</i>

### Ticket status
`valid` and `out` tickets are the only statuses eligible to admit entry into an event.

Status                         | Description
------------------------------ | --------------------
`valid`                        | Ticket is valid and can be checked in or scanned.
`redeemed`                     | Ticket was checked in and cannot be scanned again. See `checkin_at` for timestamp of when scan occurred.
`out`                          | Ticket was scanned out (after having been previously `redeemed`)
`invalidated`                  | No longer usable, but not deleted.
`transferred`                  | Contact transferred ticket to another contact. No longer scan eligible. A new ticket was created and issued to replace this one.
`pending`                      | When a contact creates an `Order`, tickets are `pending` until the order checkout process is completed.


### Ticket relationships

Key                            | Relationship         | Type          | Description
------------------------------ | -------------------- | ------------- | --------------
`contact`                      | `Contact`            | `object`      | The ticket owner.
`custom_fields`                | `TicketCustomField`  | `array`       | Any custom fields specified, e.g. "Title", or "Company"
`tags`                         | `Tag`                | `array`       | Tag tickets to group and track tickets according to your use case.
`scans`                        | `Scan`               | `array`       | A record of every action taken on this ticket, e.g. checked in, checked out, duplicate scan, etc.
`emails`                       | `Email`              | `array`       | All the emails sent out relating to this ticket.

## Ticket type
A ticket type is an account wide, re-usable object.

> Ticket type object

```json
{
    "id": 7456,
    "created_at": "2019-01-07T21:56:42.755038Z",
    "updated_at": "2019-01-07T21:56:42.774215Z",
    "archived_at": null,
    "name": "GA",
    "display_name": null,
    "pdf_template_id": null,
    "wallet_template_id": null,
    "attachable": true,
    "transferable": true,
    "include_name": false,
    "include_email": false,
    "require_name": false,
    "require_email": false,
    "enforce_barcode_pool": false,
    "attachment_name": "{{ticket.name}}"
}
```

Attribute                      | Type       | Default              | Description
------------------------------ | ---------- | -------------------- | -----------------
`name`                         | `string`   |                      | Name of the ticket type.
`display_name`                 | `string`   |                      | What is displayed to the guest, e.g. on the PDF. Defaults to the `name` if left blank.
`pdf_template_id`              | `integer`  |                      | ID number of the associated PDF template.
`wallet_template_id`           | `integer`  |                      | ID number of the associated Apple Wallet template.
`transferable`                 | `boolean`  | `true`               | Whether guests can transfer this ticket type to another guest.
`attachable`                   | `boolean`  | `true`               | Whether tickets are attached in emails (true) or provided as a download link (false).
`include_name`                 | `boolean`  | `false`              | Collect a name for each ticket (applies only during order checkout or responding to an invite/RSVP)
`include_email`                | `boolean`  | `false`              | Collect an email for each ticket (applies only during order checkout or responding to an invite/RSVP)
`require_name`                 | `boolean`  | `false`              | Require a name for each ticket (applies only during order checkout or responding to an invite/RSVP)
`require_email`                | `boolean`  | `false`              | Require an email for each ticket (applies only during order checkout or responding to an invite/RSVP)
`enforce_barcode_pool`         | `boolean`  | `false`              | Whether tickets can only be created if a barcode exists in the pool.
`attachment_name`              | `string`   | `{{ticket.name}}`    | How the attachment file name is formatted when including the ticket in an email.


## Event ticket type
An event ticket type associates a ticket type to a specific event. Will inherit configuration from the ticket type, unless a matching attribute is overridden (`pdf_template_id`)

> Event ticket type object

```json
{
    "id": 19057,
    "created_at": "2019-01-07T21:56:42.769762Z",
    "updated_at": "2019-01-07T21:56:42.769762Z",
    "ticket_type_id": 7456,
    "event_id": 71389,
    "starts_at": null,
    "ends_at": null,
    "pdf_template_id": null
}
```

Attribute                      | Type        | Description
------------------------------ | ----------- | -----------
`ticket_type_id`               | `integer`   | ID of associated ticket type. <i class="label label-info">read-only</i>
`event_id`                     | `integer`   | ID of associated event. <i class="label label-info">read-only</i>
`starts_at`                    | `datetime`  | When this ticket is valid from. Display purposes only.
`ends_at`                      | `datetime`  | When this ticket is valid until. Display purposes only.
`pdf_template_id`              | `integer`   | Override the ticket type if necessary.

### Relationships

Field                  | Type     | Description
---------------------- | -------- | -----------
`ticket_type`          | `object` | The ticket type.

## Registration types

> Registration type object

```json
{
    "id": 10,
    "variant_id": 1852,
    "name": "General admission",
    "description": "<p>description</p>",
    "stock_item": {
        "id": 17051,
        "status": "not_on_sale",
        "available": 0
    },
    "prices": [
        {
            "decimal": "0.0",
            "amount": 0,
            "currency": "AUD",
            "default": true,
            "formatted": "$0.00"
        }
    ]
}
```

Field                      | Type     | Description
-------------------------- | -------- | -----------
`name`                     | integer  |
`variant_id`               | integer  | The linked product. Use this ID to create orders. <i class="label label-info">read-only</i>
`description`              | integer  | HTML description.

### Relationships

Field                  | Type     | Description
---------------------- | -------- | -----------
`stock_item`           | `object` | Inventory details
`prices`               | `array`  | Price information


## Stock item

> Stock item object

```json
{
    "id": 17051,
    "status": "not_on_sale",
    "available": 0
}
```

Field                      | Type       | Description
-------------------------- | ---------- | -----------
`id`                       | `integer`  |
`status`                   | `string`   | One of `selling`, `paused`, `reserve`, `request`, `not_on_sale`, `sold_out` <i class="label label-info">read-only</i>
`available`                | `integer`  | Quantity currently in stock. <i class="label label-info">read-only</i>

### Status descriptions

* `selling`: This item is ready for sale.
* `paused`: Sales are currently paused.
* `reserve`: Item can be added to cart and reserved, but cannot be paid for (not on sale yet).
* `request`: Item can be added to cart and requested, but cannot be paid for (wait list).
* `not_on_sale`: Item is not on sale yet.
* `sold_out`: Item is sold out. `available` is zero.

## Price

> Price object

```json
{
    "decimal": "9.5",
    "amount": 950,
    "currency": "AUD",
    "default": true,
    "formatted": "$9.50"
}
```

Field                      | Type       | Description
-------------------------- | ---------- | -----------
`decimal`                  | `string`   | Convert this to a `BigDecimal`
`amount`                   | `integer`  | Cents.
`currency`                 | `string`   | ISO identifier for the currency.
`default`                  | `boolean`  | Whether this is the default price for the product.
`formatted`                | `string`   | Friendly format for the amount, e.g. `$1,250.99`

## Order

> Order object

```json
{
    "id": 176260,
    "number": "GM720XKYDP5SLR",
    "state": "cart",
    "checkout_steps": [
        "email",
        "register",
        "tickets",
        "address",
        "form",
        "complete"
    ],
    "contact_id": null,
    "guest_checkout": false,
    "first_name": "Jeff",
    "last_name": "Blake",
    "email": "jeff.blake2@gmail.com",
    "phone_number": "+61491570156",
    "phone_number_country": "AU",
    "item_count": 1,
    "total": "0.0",
    "item_total": "0.0",
    "adjustment_total": "0.0",
    "promo_total": "0.0",
    "currency": "AUD",
    "completed_at": null,
    "expires_at": "2017-10-25T17:54:51.557604Z",
    "links": {
        "cart": "http://miele.guestmanager.dev:3000/cart?guest_token=5b8fa186f25a225fbe95744baf6326fb&id=GM720XKYDP5SLR",
        "checkout": "http://miele.guestmanager.dev:3000/cart/checkout/GM720XKYDP5SLR?guest_token=5b8fa186f25a225fbe95744baf6326fb"
    },
    "payment_methods": [
        {
            "id": 78,
            "type": "Gateway::Stripe",
            "name": "Stripe",
            "description": null,
            "display_name": "Credit Card",
            "currencies": [
                "AUD"
            ],
            "billing_address_required": true,
            "payment_profiles_enabled": true,
            "test_mode": false,
            "active": true,
            "tokenize_key": "pk_live_*****"
        }
    ],
    "line_items": [
        {
            "id": 176643,
            "order_id": 176260,
            "name": "Free",
            "description": null,
            "variant_id": 6522,
            "quantity": 1,
            "price": "0.0",
            "amount": "0.0",
            "currency": "AUD",
            "bundle_item_id": null,
            "ticket_tier": {
                "name": "Complimentary Owner Product Demonstrations",
                "event": {
                    "name": "Oven",
                    "date": "04-11-2017",
                    "time": "10:30am-12:00pm",
                    "venue": "Knoxfield"
                }
            }
        }
    ],
    "adjustments": [],
    "promotions": [],
    "tickets": []
}

```

Attribute                      | Type       | Description
------------------------------ | ---------- | -----------
`number`                       | `string`   | Order number. <i class="label label-info">read-only</i>
`state`                        | `string`   | The current step of the order. See order states. <i class="label label-info">read-only</i>
`checkout_steps`               | `array`    | List of all states dynamically computed for this order. Can change from state to state. <i class="label label-info">read-only</i>
`contact_id`                   | `integer`  | The guest associated to this order. <i class="label label-info">read-only</i>
`guest_token`                  | `string`   | Unique token for the session. Submit this back to GM for any requests that modify this order. <i class="label label-info">read-only</i>
`payment_state`                | `string`   | Current payment status. See payment states. <i class="label label-info">read-only</i>
`currency`                     | `string`   | ISO code of currency. All items added to order must have a price available in this currency.
`item_count`                   | `integer`  | Number of items in the order. Sum of all `line_item.quantity` <i class="label label-info">read-only</i>
`total`                        | `money`    | Grand (net) total, after adjustments, promotions, fees, and taxes. <i class="label label-info">read-only</i>
`item_total`                   | `money`    | Sum of all `line_item.price x line_item.quantity` <i class="label label-info">read-only</i>
`adjustment_total`             | `money`    | Sum of all non-line-item charges (promotions, taxes, fees, etc). <i class="label label-info">read-only</i>
`payment_total`                | `money`    | Sum of all completed payments. <i class="label label-info">read-only</i>
`additional_tax_total`         | `money`    | Additional taxes passed onto the guest. <i class="label label-info">read-only</i>
`included_tax_total`           | `money`    | Included taxes. <i class="label label-info">read-only</i>
`included_service_fee_total`   | `money`    | Included fees. <i class="label label-info">read-only</i>
`additional_service_fee_total` | `money`    | Extra fees passed onto the guest. <i class="label label-info">read-only</i>
`promo_total`                  | `money`    | The discount on this order. <i class="label label-info">read-only</i>
`shipment_total`               | `money`    | Total shipping charges. <i class="label label-info">read-only</i>
`taxable_adjustment_total`     | `money`    |
`non_taxable_adjustment_total` | `money`    |
`application_fee_total`        | `money`    | The fee charged by Guest Manager. <i class="label label-info">read-only</i>
`expires_at`                   | `datetime` | When the items are released back into inventory. Default 15 minutes.
`completed_at`                 | `datetime` | When the order was completed. <i class="label label-info">read-only</i>
`abandon_at`                   | `datetime` | When the order will be marked as abandoned. Configured via `CheckoutCustomization` <i class="label label-info">read-only</i>
`can_checkout_at`              | `datetime` | If the order is `reserved`, the time at which the order will be eligible for completion. <i class="label label-info">read-only</i>
`created_by_id`                | `integer`  | The admin who created this order. <i class="label label-info">read-only</i>
`canceler_id`                  | `integer`  | The admin who canceled this order. <i class="label label-info">read-only</i>
`approver_id`                  | `integer`  | The admin who approved this order. <i class="label label-info">read-only</i>
`holder_id`                    | `integer`  | The admin who held this order. <i class="label label-info">read-only</i>
`company_id`                   | `integer`  | The company associated to this order. <i class="label label-info">read-only</i>
`checkout_customization_id`    | `integer`  | The checkout configuration. <i class="label label-info">read-only</i>
`zone_id`                      | `integer`  | Tax zone. <i class="label label-info">read-only</i>
`order_form_id`                | `integer`  | Related order form.
`order_channel_id`             | `integer`  | Related order channel for tracking purposes.
`shipping_method_id`           | `integer`  | Chosen shipping method.
`bill_address_id`              | `integer`  | Billing address.
`ship_address_id`              | `integer`  | Shipping address.
`shipment_state`               | `string`   | Status of shipment.
`email_state`                  | `string`   |
`metadata`                     | `object`   | Extra data stored in order.
`mobile`                       | `boolean`  | If the order was placed on a mobile device.
`locked`                       | `boolean`  | If the order is locked for updates.
`last_ip_address`              | `string`   | Last known ip address of guest.
`message`                      | `text`     | Admin note.

### Order relationships

Attribute                    | Type      | Description
---------------------------- | --------- | -----------
`bill_address`               | `object`  | Billing address.
`ship_address`               | `object`  | Shipping address.
`line_items`                 | `array`   | Items in the order.
`payment_methods`            | `array`   | Available payment methods.
`tickets`                    | `array`   | Tickets relevant to the line items.
`responses`                  | `array`   | Surveys/questions.
`payments`                   | `array`   | Payments made on this order.
`promotions`                 | `array`   | If any promo's were applied to this order. If so, a corresponding `Adjustment` will be present on the order or line item.
`adjustments`                | `array`   | An adjustment could be a service fee, tax, or discount. An adjustment is usually applied to a `LineItem`, but may also be applied directly to an order.

### Order states

`state`        | Description
-------------- | -----------
`cart`         | Default state for all newly created orders.
`expired`      | Order was not completed within 15 minutes of creation. Can be resumed.
`voided`       | Voided by an admin. Cannot be resumed.
`canceled`     | Canceled by admin or guest. Cannot be resumed.
`abandoned`    | No action was taken on order X hours after expired. Enabled if Abandoned Cart Recovery feature is configured.

### Guest checkout properties
Add these attributes through either the create or update order endpoint.
The `contact_id` attribute will be set on the order through a find or create process based on the provided email and phone number.

Attribute                    | Type      | Description
---------------------------- | --------- | -----------
`guest_checkout`             | `boolean` | Set this to `true` to enable guest checkout.
`first_name`                 | `string`  | First name of guest.
`last_name`                  | `string`  | Last name of guest.
`email`                      | `string`  | Email address of guest. Format is validated.
`phone_number`               | `string`  | Phone number of guest. <br>Format is validated according to the `phone_number_country` provided.
`phone_number_country`       | `string`  | Country of the phone number. 2 digit ISO code, uppercase.

### Line item properties

Attribute                    | Type      | Description
---------------------------- | --------- | -----------
`order_id`                   | `integer` | The order. <i class="label label-info">read-only</i>
`name`                       | `string`  | Variant name. <i class="label label-info">read-only</i>
`description`                | `string`  |
`variant_id`                 | `integer` | The product variation in the cart.
`quantity`                   | `integer` | number of items.
`price`                      | `money`   | per unit price.
`amount`                     | `money`   | `price * quantity` <i class="label label-info">read-only</i>
`currency`                   | `string`  | ISO code.
`bundle_item_id`             | `integer` | The parent `LineItem` this `LineItem` is bundled under. <i class="label label-info">read-only</i>
`adjustments`                | `array`   | adjustments related to this line item. (fees, taxes, promotions) <i class="label label-info">read-only</i>
`tickets`                    | `array`   | Tickets issued as specified by the variant's package. <i class="label label-info">read-only</i>


### Adjustment properties

Attribute                    | Type      | Description
---------------------------- | --------- | -----------
`label`                      | `string`  | Description of the adjustment.
`order_id`                   | `integer` | Order. <i class="label label-info">read-only</i>
`adjustable_id`              | `integer` | ID of what this adjustment is adjusting <i class="label label-info">read-only</i>
`adjustable_type`            | `string`  | The model of what this adjustment is adjusting. One of `Order` or `LineItem` <i class="label label-info">read-only</i>
`amount`                     | `money`   | Dollar amount.
`source_id`                  | `integer` | ID of what created this adjustment. <i class="label label-info">read-only</i>
`source_type`                | `string`  | The model of what created this adjustment. One of `ServiceFeeRate`, `TaxRate`, `PromotionAction` <i class="label label-info">read-only</i>
`included`                   | `boolean` | Whether the amount is included in the `adjustable` total, or added on top. <i class="label label-info">read-only</i>
`mandatory`                  | `boolean` |
`eligible`                   | `boolean` | If this adjustment is eligible, determined by `source` <i class="label label-info">read-only</i>
`groupable`                  | `boolean` | Whether this adjustment can be grouped into a total amount (e.g. taxes), or must be listed out separately. <i class="label label-info">read-only</i>
`finalized`                  | `boolean` | If this adjustment can be modified. <i class="label label-info">read-only</i>
`application_fee`            | `boolean` | If this amount is monies owed to Guest Manager. <i class="label label-info">read-only</i>

### Payment properties

Attribute                    | Type      | Description
---------------------------- | --------- | -----------
`number`                     | `string`  | Unique identifier.
`amount`                     | `money`   | Payment amount.
`state`                      | `string`  | status of the payment.
`order_id`                   | `integer` | Order ID.
`source_id`                  | `integer` |
`source_type`                | `string`  |
`payment_method_id`          | `integer` |
`response_code`              | `string`  | Response from payment gateway. Typically is the unique identifier used by the gateway.
`application_fee`            | `money`   | Monies routed to Guest Manager.
`reason`                     | `string`  | A decline reason.

#### Payment states

`payment_state`    | Description
------------------ | ---------------
`paid`             | `payment_total == total`
`balance_due`      | `payment_total < total`
`credit_owed`      | `payment_total > total`
`partial_refund`   | Some items have been refunded.
`refunded`         | All items have been refunded.
`failed`           | Payment failed.

## Payment method

Attribute                    | Type      | Description
---------------------------- | --------- | -----------
`type`                       | `string`  | <i class="label label-info">read-only</i>
`name`                       | `string`  |
`description`                | `string`  |
`display_name`               | `string`  |
`currencies`                 | `array`   | A list of currencies this payment method supports.
`billing_address_required`   | `boolean` |
`payment_profiles_enabled`   | `boolean` |
`test_mode`                  | `boolean` |
`active`                     | `boolean` |
`tokenize_key`               | `string`  | If the gateway supports credit card tokenization, use this key to generate a token clientside before submitting to the API. <i class="label label-info">read-only</i>

## Venue

> Venue object

```json
{
    "id": 0,
    "name": "Knoxfield",
    "description": null,
    "slug": "knoxfield",
    "created_at": "2016-09-19T20:35:16.794759Z",
    "updated_at": "2018-06-11T01:17:40.799858Z",
    "time_zone": "Melbourne",
    "tzinfo": {
        "name": "Melbourne",
        "identifier": "Australia/Melbourne",
        "offset": 36000,
        "formatted_offset": "+10:00"
    },
    "address": {
        "id": 78013,
        "address1": "206-210 Coventry Street",
        "city": "South Melbourne",
        "zipcode": "3205",
        "state_name": "Victoria",
        "state_code": "VIC",
        "country_name": "Australia",
        "country_code": "AU"
    }
}
```

Attribute                      | Type       | Description
------------------------------ | ---------- | -----------
`name`                         | `string`   | Name of the venue.
`description`                  | `text`     | Additional line can be used to describe the venue.
`slug`                         | `string`   | Auto-generated for use in url-generation.
`time_zone`                    | `string`   | Time zone where the venue is located.
`tzinfo`                       | `object`   | Details about the time zone. <i class="label label-info">read-only</i>

### Venue relationships

Key                            | Relationship     | Type
------------------------------ | ---------------- | -----------
`address`                      | `Address`        | `object`


## Response
A response is a form submission, typically completed during an order checkout process.

> Form response object

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

Attribute                         | Type       | Description
--------------------------------- | ---------- | -----------
`form_id`                         | `integer`  | The referenced `Form` <i class="label label-info">read-only</i>

### Response relationships

Key                            | Relationship     | Type
------------------------------ | ---------------- | -----------
`answers`                      | `Answer`         | `array`

### Answer attributes

Attribute                         | Type              | Description
--------------------------------- | ----------------- | -----------
`form_field_id`                   | `integer`         | The question being answered. <i class="label label-info">read-only</i>
`value`                           | `string|array`    | The actual answer. For `multiple_choice` questions, this is the `option.id`
`human_value`                     | `string`          | If `multiple_choice`, the name of the option. <i class="label label-info">read-only</i>

### Answer relationships

Key                            | Relationship     | Type
------------------------------ | ---------------- | -----------
`field`                        | `Field`          | `object`

### Field attributes

Attribute                         | Type       | Description
--------------------------------- | ---------- | -----------
`type`                            | `string`   | The kind of question being asked. `text_field`, `multiple_choice`
`label`                           | `string`   | Question being asked.
`required`                        | `boolean`  |
`enabled`                         | `boolean`  |
`help_text`                       | `string`   | Additional information about the question.

### Field relationships

Key                            | Relationship     | Type        | Description
------------------------------ | ---------------- | ----------- | --------------
`options`                      | `Option`         | `array`     | If `type` is `multiple_choice`, these are the possible answers.

### Option attributes

Attribute                         | Type       | Description
--------------------------------- | ---------- | -----------
`form_field_id`                   | `integer`  | The kind of question being asked. `text_field`, `multiple_choice`
`name`                            | `string`   | The option value/name.
`position`                        | `integer`  | How to sort the option.


## Address

> Address object

```json
{
    "id": 78013,
    "address1": "206-210 Coventry Street",
    "city": "South Melbourne",
    "zipcode": "3205",
    "state_name": "Victoria",
    "state_code": "VIC",
    "country_name": "Australia",
    "country_code": "AU"
}
```

For convenience, you can provide either `country_code` and `state_code` in place of `country_id` and `state_id`

Field                          | Type                                                 | Description
------------------------------ | ---------------------------------------------------- | -----------
`address1`                     | `string`                                             | Line 1.
`address2`                     | `string`                                             | Line 2.
`city`                         | `string`                                             | City
`zipcode`                      | `string`                                             | Zip code / postal code.
`state_name`                   | `string` <i class="label label-info">read-only</i>   | Name of the State.
`state_code`                   | `string`                                             | Abbreviation of the State.
`country_name`                 | `string` <i class="label label-info">read-only</i>   | Name of the country.
`country_code`                 | `string`                                             | ISO code of the Country.
`state_id`                     | `integer`                                            | ID of state.
`country_id`                   | `integer`                                            | ID of country.
`state`                        | `object` <i class="label label-info">read-only</i>   | `State`
`country`                      | `object` <i class="label label-info">read-only</i>   | `Country`


## Country

> Country object

```json
{
    "id": 3,
    "name": "Afghanistan",
    "code": "AF",
    "phone_prefix": "93",
    "currency_code": "AFN"
}
```

Field                          | Type                                                 | Description
------------------------------ | ---------------------------------------------------- | -----------
`name`                         | `string` <i class="label label-info">read-only</i>   | Name of the country.
`code`                         | `string` <i class="label label-info">read-only</i>   | ISO code of the country.
`currency_code`                | `string` <i class="label label-info">read-only</i>   | Currency ISO code.
`phone_prefix`                 | `string` <i class="label label-info">read-only</i>   | Phone prefix.


## State

> State object

```json
{
    "id": 4122,
    "name": "Alabama",
    "country_id": 234,
    "code": "AL"
}
```

Field                          | Type                                                 | Description
------------------------------ | ---------------------------------------------------- | -----------
`name`                         | `string` <i class="label label-info">read-only</i>   | Name of the state.
`code`                         | `string` <i class="label label-info">read-only</i>   | Abbreviation of the state name.
`country_id`                   | `integer` <i class="label label-info">read-only</i>  | The country this state is in.



## Time zones

Use the first column in the table below to determine which time zone to submit.

Name                                        | TZ                        | UTC Offset
------------------------------------------- | ------------------------- | ---------------
International Date Line West                | Etc/GMT+12                | -12:00
American Samoa                              | Pacific/Pago_Pago         | -11:00
Midway Island                               | Pacific/Midway | -11:00
Hawaii                                      | Pacific/Honolulu | -10:00
Alaska                                      | America/Juneau | -09:00
Pacific Time (US & Canada)                  | America/Los_Angeles | -08:00
Tijuana | America/Tijuana | -08:00
Arizona | America/Phoenix | -07:00
Chihuahua | America/Chihuahua | -07:00
Mazatlan | America/Mazatlan | -07:00
Mountain Time (US & Canada) | America/Denver | -07:00
Central America | America/Guatemala | -06:00
Central Time (US & Canada) | America/Chicago | -06:00
Guadalajara | America/Mexico_City | -06:00
Mexico City | America/Mexico_City | -06:00
Monterrey | America/Monterrey | -06:00
Saskatchewan | America/Regina | -06:00
Bogota | America/Bogota | -05:00
Eastern Time (US & Canada) | America/New_York | -05:00
Indiana (East) | America/Indiana/Indianapolis | -05:00
Lima | America/Lima | -05:00
Quito | America/Lima | -05:00
Atlantic Time (Canada) | America/Halifax | -04:00
Caracas | America/Caracas | -04:00
Georgetown | America/Guyana | -04:00
La Paz | America/La_Paz | -04:00
Puerto Rico | America/Puerto_Rico | -04:00
Santiago | America/Santiago | -04:00
Newfoundland | America/St_Johns | -03:30
Brasilia | America/Sao_Paulo | -03:00
Buenos Aires | America/Argentina/Buenos_Aires | -03:00
Greenland | America/Godthab | -03:00
Montevideo | America/Montevideo | -03:00
Mid-Atlantic | Atlantic/South_Georgia | -02:00
Azores | Atlantic/Azores | -01:00
Cape Verde Is. | Atlantic/Cape_Verde | -01:00
Casablanca | Africa/Casablanca | +00:00
Dublin | Europe/Dublin | +00:00
Edinburgh | Europe/London | +00:00
Lisbon | Europe/Lisbon | +00:00
London | Europe/London | +00:00
Monrovia | Africa/Monrovia | +00:00
UTC | Etc/UTC | +00:00
Amsterdam | Europe/Amsterdam | +01:00
Belgrade | Europe/Belgrade | +01:00
Berlin | Europe/Berlin | +01:00
Bern | Europe/Zurich | +01:00
Bratislava | Europe/Bratislava | +01:00
Brussels | Europe/Brussels | +01:00
Budapest | Europe/Budapest | +01:00
Copenhagen | Europe/Copenhagen | +01:00
Ljubljana | Europe/Ljubljana | +01:00
Madrid | Europe/Madrid | +01:00
Paris | Europe/Paris | +01:00
Prague | Europe/Prague | +01:00
Rome | Europe/Rome | +01:00
Sarajevo | Europe/Sarajevo | +01:00
Skopje | Europe/Skopje | +01:00
Stockholm | Europe/Stockholm | +01:00
Vienna | Europe/Vienna | +01:00
Warsaw | Europe/Warsaw | +01:00
West Central Africa | Africa/Algiers | +01:00
Zagreb | Europe/Zagreb | +01:00
Zurich | Europe/Zurich | +01:00
Athens | Europe/Athens | +02:00
Bucharest | Europe/Bucharest | +02:00
Cairo | Africa/Cairo | +02:00
Harare | Africa/Harare | +02:00
Helsinki | Europe/Helsinki | +02:00
Jerusalem | Asia/Jerusalem | +02:00
Kaliningrad | Europe/Kaliningrad | +02:00
Kyiv | Europe/Kiev | +02:00
Pretoria | Africa/Johannesburg | +02:00
Riga | Europe/Riga | +02:00
Sofia | Europe/Sofia | +02:00
Tallinn | Europe/Tallinn | +02:00
Vilnius | Europe/Vilnius | +02:00
Baghdad | Asia/Baghdad | +03:00
Istanbul | Europe/Istanbul | +03:00
Kuwait | Asia/Kuwait | +03:00
Minsk | Europe/Minsk | +03:00
Moscow | Europe/Moscow | +03:00
Nairobi | Africa/Nairobi | +03:00
Riyadh | Asia/Riyadh | +03:00
St. Petersburg | Europe/Moscow | +03:00
Volgograd | Europe/Volgograd | +03:00
Tehran | Asia/Tehran | +03:30
Abu Dhabi | Asia/Muscat | +04:00
Baku | Asia/Baku | +04:00
Muscat | Asia/Muscat | +04:00
Samara | Europe/Samara | +04:00
Tbilisi | Asia/Tbilisi | +04:00
Yerevan | Asia/Yerevan | +04:00
Kabul | Asia/Kabul | +04:30
Ekaterinburg | Asia/Yekaterinburg | +05:00
Islamabad | Asia/Karachi | +05:00
Karachi | Asia/Karachi | +05:00
Tashkent | Asia/Tashkent | +05:00
Chennai | Asia/Kolkata | +05:30
Kolkata | Asia/Kolkata | +05:30
Mumbai | Asia/Kolkata | +05:30
New Delhi | Asia/Kolkata | +05:30
Sri Jayawardenepura | Asia/Colombo | +05:30
Kathmandu | Asia/Kathmandu | +05:45
Almaty | Asia/Almaty | +06:00
Astana | Asia/Dhaka | +06:00
Dhaka | Asia/Dhaka | +06:00
Urumqi | Asia/Urumqi | +06:00
Rangoon | Asia/Rangoon | +06:30
Bangkok | Asia/Bangkok | +07:00
Hanoi | Asia/Bangkok | +07:00
Jakarta | Asia/Jakarta | +07:00
Krasnoyarsk | Asia/Krasnoyarsk | +07:00
Novosibirsk | Asia/Novosibirsk | +07:00
Beijing | Asia/Shanghai | +08:00
Chongqing | Asia/Chongqing | +08:00
Hong Kong | Asia/Hong_Kong | +08:00
Irkutsk | Asia/Irkutsk | +08:00
Kuala Lumpur | Asia/Kuala_Lumpur | +08:00
Perth | Australia/Perth | +08:00
Singapore | Asia/Singapore | +08:00
Taipei | Asia/Taipei | +08:00
Ulaanbaatar | Asia/Ulaanbaatar | +08:00
Osaka | Asia/Tokyo | +09:00
Sapporo | Asia/Tokyo | +09:00
Seoul | Asia/Seoul | +09:00
Tokyo | Asia/Tokyo | +09:00
Yakutsk | Asia/Yakutsk | +09:00
Adelaide | Australia/Adelaide | +09:30
Darwin | Australia/Darwin | +09:30
Brisbane | Australia/Brisbane | +10:00
Canberra | Australia/Melbourne | +10:00
Guam | Pacific/Guam | +10:00
Hobart | Australia/Hobart | +10:00
Melbourne | Australia/Melbourne | +10:00
Port Moresby | Pacific/Port_Moresby | +10:00
Sydney | Australia/Sydney | +10:00
Vladivostok | Asia/Vladivostok | +10:00
Magadan | Asia/Magadan | +11:00
New Caledonia | Pacific/Noumea | +11:00
Solomon Is. | Pacific/Guadalcanal | +11:00
Srednekolymsk | Asia/Srednekolymsk | +11:00
Auckland | Pacific/Auckland | +12:00
Fiji | Pacific/Fiji | +12:00
Kamchatka | Asia/Kamchatka | +12:00
Marshall Is. | Pacific/Majuro | +12:00
Wellington | Pacific/Auckland | +12:00
Chatham Is. | Pacific/Chatham | +12:45
Nuku'alofa | Pacific/Tongatapu | +13:00
Samoa | Pacific/Apia | +13:00
Tokelau Is. | Pacific/Fakaofo | +13:00