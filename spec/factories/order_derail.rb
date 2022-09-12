require "faker"

FactoryBot.define do
  factory :order_detail do
    product_size {FactoryBot.create :product_size}
    product_size_id { product_size.id }
    num { 1 }
    price { product_size.product.unit_price }
  end
end
