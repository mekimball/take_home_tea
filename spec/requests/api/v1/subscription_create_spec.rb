require 'rails_helper'

RSpec.describe 'Subscriptions' do
  before do
    @customer_1 = Customer.create!(first_name: 'John', last_name: 'Smith', email: 'john@example.com', address: '123 Main Street')
    @subscription_1 = Subscription.create!(title: 'basic', price: 5.99, status: 'active', frequency: 'every two weeks', customer_id: @customer_1.id)
    @tea_1 = Tea.create!(title: 'green tea', description: 'yummy', temperature: 179, brew_time: 5, subscription_id: @subscription_1.id)
    @tea_2 = Tea.create!(title: 'oolong tea', description: 'also yummy', temperature: 185, brew_time: 7, subscription_id: @subscription_1.id)
  end
  it 'can create a subscription' do
    
  end
end