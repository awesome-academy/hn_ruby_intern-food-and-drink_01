require "faker"

FactoryBot.define do
  factory :product do
    name { Faker::Food.unique.dish }
    description  { Faker::Food.description }
    unit_price { Faker::Commerce.price(range: 1..100.0) }
    quantity { Faker::Commerce.price(range: 1..100.0) }
    thumbnail { Faker::Avatar.image }
    category {FactoryBot.create :category}
    category_id {category.id}
    after(:build) do |product|
      product.image.attach(io: File.open("#{Rails.root}/app/assets/images/images/phot1.jpg"), filename: 'soy.jpeg', content_type: 'image/jpeg')
    end
  end
end
