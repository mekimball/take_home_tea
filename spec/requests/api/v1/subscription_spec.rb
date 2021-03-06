require 'rails_helper'

RSpec.describe 'Subscriptions' do
  before do
    @customer_1 = Customer.create!(first_name: 'John', last_name: 'Smith', email: 'john@example.com', address: '123 Main Street')
    @tea_1 = Tea.create!(title: 'green tea', description: 'yummy', temperature: 179, brew_time: 5)
    @tea_2 = Tea.create!(title: 'oolong tea', description: 'also yummy', temperature: 185, brew_time: 7)
    @subscription_1 = Subscription.create!(title: 'basic', price: 5.99, status: 'active', frequency: 'every two weeks', customer_id: @customer_1.id, tea_id: @tea_1.id)
    @subscription_2 = Subscription.create!(title: 'bougie', price: 15.99, status: 'active', frequency: 'daily', customer_id: @customer_1.id, tea_id: @tea_2.id)

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

  it 'can cancel a subscription' do
    subscription_3 = Subscription.create!(title: 'bougie', price: 15.99, status: 'active', frequency: 'daily', customer_id: @customer_1.id, tea_id: @tea_2.id)

    update_params = {
      status: 'inactive'
    }
    headers = { 'CONTENT_TYPE' => 'application/json' }
    patch "/api/v1/customers/#{@customer_1.id}/subscriptions/#{subscription_3.id}", headers: headers,
                          params: JSON.generate(subscription: update_params)
    updated = Subscription.find_by(id: subscription_3.id)
    expect(response.status).to eq(201)

    expect(updated.status).to eq('inactive')
  end

  it 'can return all subscriptions from a customer' do
    get "/api/v1/customers/#{@customer_1.id}/subscriptions"
    parsed = JSON.parse(response.body, symbolize_names: true)
    subs = parsed[:data]

    subs.each do |sub|
      expect(sub).to have_key(:id)
      expect(sub[:id]).to be_a(String)
      expect(sub).to have_key(:type)
      expect(sub[:type]).to be_a(String)
      expect(sub[:attributes]).to have_key(:title)
      expect(sub[:attributes][:title]).to be_a(String)
      expect(sub[:attributes]).to have_key(:price)
      expect(sub[:attributes][:price]).to be_a(Float)
    end
  end

  it "returns an error if it can't create a subscription" do
    subscription_params = {
      title: 'premium',
      price: 10.99,
      status: 'active',
      customer_id: @customer_1.id,
      tea_id: @tea_2.id
    }
    headers = { 'CONTENT_TYPE' => 'application/json' }
    post "/api/v1/customers/#{@customer_1.id}/subscriptions", headers: headers,
                          params: JSON.generate(subscription: subscription_params)
    created_subscription = Subscription.last

    expect(response.status).to eq(400)
  end

  it 'can returns an error if customer does not exist' do
    get "/api/v1/customers/999999/subscriptions"

    expect(response.status).to eq(400)
  end
end