# The Fantastic Tea Subscription App

* Ruby version
  * 2.7.2
* Rails version
  * 6.1.4 

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

To cancel a subscription:<br>
PATCH `api/v1/customers/#{customer_id}/subscriptions/#{subscription_id}/`
with a body of:
```
{
    "status": "inactive",
 }
 ```
which will change the status to inactive.
