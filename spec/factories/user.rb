require "faker"

FactoryBot.define do
  factory :user do
    name { Faker::Name.name }
    email  { Faker::Internet.email }
    phone_num { Faker::PhoneNumber.subscriber_number(length: 10) }
    address {Faker::Address.full_address}
    password {"123456"}
    password_confirmation {"123456"}
    role {Faker::Number.within(range: 0..1)}
  end
end
