

50.times do
  title = Faker::Book.unique.title
  description = Faker::Lorem.sentence(word_count: 50)
  price = Faker::Commerce.price(range: 1..100.0)
  thumbnail = Faker::Avatar.image
  Product.create!(name: title,
               unit_price: price,
               image: thumbnail,
               description: description,
               category_id: Category.find(1).id,
               created_at: (rand*30).days.ago,
               updated_at: (rand*30).days.ago
  )
end

50.times do
  title = Faker::Beer.unique.name
  description = Faker::Food.description
  price = Faker::Commerce.price(range: 1..100.0)
  thumbnail = Faker::Avatar.image
  Product.create!(name: title,
               description: description,
               unit_price: price,
               image: thumbnail,
               category_id: Category.find(2).id,
               created_at: (rand*30).days.ago
  )
end

Size.create!(
  size: 1
)

Size.create!(
  size: 2
)

Size.create!(
  size: 3
)

20.times do
  coefficient = Faker::Commerce.price(range: 1..100.0)
  ProductSize.create!(coefficient: coefficient,
                      product_id: Product.all.pluck(:id).sample,
                      size_id: Size.all.pluck(:id).sample
  )
end
