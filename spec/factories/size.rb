require "faker"

FactoryBot.define do
  factory :size do
    size { Faker::Name.initials(number: 10) }
  end
end
