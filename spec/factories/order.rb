require "faker"

FactoryBot.define do
  factory :order do
    name { Faker::Food.unique.dish }
    phone_num { Faker::PhoneNumber.subscriber_number(length: 10) }
    address {Faker::Address.full_address}
    note  { Faker::Food.description }
    status {Faker::Number.within(range: 0..3)}
    total_money { Faker::Commerce.price(range: 1..100.0) }
    user {FactoryBot.create :user}
    user_id { user.id }
  end
end
