# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
    customer_1 = Customer.create!(first_name: 'John', last_name: 'Smith', email: 'john@example.com', address: '123 Main Street')
    tea_1 = Tea.create!(title: 'green tea', description: 'yummy', temperature: 179, brew_time: 5)
    tea_2 = Tea.create!(title: 'oolong tea', description: 'also yummy', temperature: 185, brew_time: 7)
    subscription_1 = Subscription.create!(title: 'basic', price: 5.99, status: 'active', frequency: 'every two weeks', customer_id: customer_1.id, tea_id: tea_1.id)
    subscription_2 = Subscription.create!(title: 'bougie', price: 15.99, status: 'inactive', frequency: 'daily', customer_id: customer_1.id, tea_id: tea_1.id)