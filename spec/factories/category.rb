require "faker"

FactoryBot.define do
  factory :category do
    name { Faker::Name.initials(number: 10) }
  end
end
