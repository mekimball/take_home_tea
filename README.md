# The Fantastic Tea Subscription App
A handly little app to help manage tea subscriptions, with endpoints to create a subscription, cancel a subsctiption and to see all of a customer's subscriptions.
## Tech Stack
* Ruby version
  * 2.7.2
* Rails version
  * 6.1.4 
## Setup
Clone this repository and then run `bundle install` to install all required gems. Then run `rails db:create` to set up the database. Start your Rails server with `rails s` and then make your way to Postman using localhost:3000 to reach the desired endpoints.

## Endpoints
For customer's subscriptions, both active and inactive:<br>
GET `api/v1/customers/#{customer_id}/subscriptions`

will return something similar to:
```
{
    "data": [
        {
            "id": "1",
            "type": "subscription",
            "attributes": {
                "title": "basic",
                "price": 5.99,
                "status": "active",
                "frequency": "every two weeks",
                "customer_id": 1,
                "tea_id": 1
            }
        }
    ]
}
```
To add a new subscription:<br>
POST `api/v1/customers/#{customer_id}/subscriptions`
Post body must be in the following format:
```
{
      "title": "extra-premium",
      "price": 12.99,
      "status": "active",
      "customer_id": 1,
      "tea_id": 2
    }
 ```

To cancel a subscription:<br>
PATCH `api/v1/customers/#{customer_id}/subscriptions/#{subscription_id}/`
with a body of:
```
{
    "status": "inactive",
 }
 ```
which will change the status to inactive.
