require 'rails_helper'

RSpec.describe 'Subscriptions' do
  before do
    @customer_1 = Customer.create!(first_name: 'John', last_name: 'Smith', email: 'john@example.com', address: '123 Main Street')
    @tea_1 = Tea.create!(title: 'green tea', description: 'yummy', temperature: 179, brew_time: 5)
    @tea_2 = Tea.create!(title: 'oolong tea', description: 'also yummy', temperature: 185, brew_time: 7)
    @subscription_1 = Subscription.create!(title: 'basic', price: 5.99, status: 'active', frequency: 'every two weeks', customer_id: @customer_1.id, tea_id: @tea_1.id)
  end
  it 'can create a subscription' do
    subscription_params = {
      title: 'premium',
      price: 10.99,
      status: 'active',
      frequency: 'every week',
      customer_id: @customer_1.id,
      tea_id: @tea_2.id
    }
    headers = { 'CONTENT_TYPE' => 'application/json' }
    post "/api/v1/customers/#{@customer_1.id}/subscriptions", headers: headers,
                          params: JSON.generate(subscription: subscription_params)
    created_subscription = Subscription.last

    expect(response.status).to eq(201)
    
    expect(created_subscription.title).to eq('premium')
    expect(created_subscription.price).to eq(10.99)
    expect(created_subscription.status).to eq('active')
    expect(created_subscription.frequency).to eq('every week')
    expect(created_subscription.customer_id).to eq(@customer_1.id)
    expect(created_subscription.tea_id).to eq(@tea_2.id)

  end
end