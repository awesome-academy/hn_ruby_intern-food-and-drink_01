require "faker"

FactoryBot.define do
  factory :product_size do
    product {FactoryBot.create :product}
    product_id { product.id }
    size {FactoryBot.create :size}
    size_id { size.id }
    price { product.unit_price }
  end
end
