
User.create!(
  name: "Than Minh Nam",
  email: "thanminhnam@gmail.com",
  phone_num: "1234567890",
  address: "hihihihihihihihihihihihihihihihi",
  password: "123456",
  password_confirmation: "123456",
  role: "customer"
)

User.create!(
  name: "Than Minh Nam Nam",
  email: "thanminhnam1@gmail.com",
  phone_num: "1234567809",
  address: "hihihihihihihihihihihihihihihihi",
  password: "123456",
  password_confirmation: "123456",
  role: "admin"
)

Category.create!(
  name: "food"
)

Category.create!(
  name: "drink"
)

20.times do |n|
  title = Faker::Food.unique.dish
  description = Faker::Food.dish
  price = Faker::Commerce.price(range: 1..100.0)
  quantity = Faker::Commerce.price(range: 1..100.0)
  thumbnail = Faker::Avatar.image
  product = Product.new(name: title,
               unit_price: price,
               quantity: quantity,
               thumbnail: thumbnail,
               description: description,
               category_id: Category.all.pluck(:id).sample,
               created_at: (rand*30).days.ago,
               updated_at: (rand*30).days.ago
  )
  product.image.attach(io: File.open("#{Rails.root}/app/assets/images/images/phot#{n+1}.jpg"),
                                    filename: "photo#{n+1}.jpg",
                                    content_type: "image/jpg")
  product.save!
end

20.times do |n|
  title = Faker::Food.unique.fruits
  description = Faker::Food.dish
  price = Faker::Commerce.price(range: 1..100.0)
  quantity = Faker::Commerce.price(range: 1..100.0)
  thumbnail = Faker::Avatar.image
  product = Product.new(name: title,
               unit_price: price,
               quantity: quantity,
               thumbnail: thumbnail,
               description: description,
               category_id: Category.all.pluck(:id).sample,
               created_at: (rand*30).days.ago,
               updated_at: (rand*30).days.ago
  )
  product.image.attach(io: File.open("#{Rails.root}/app/assets/images/images/phot#{n+1}.jpg"),
                                    filename: "photo#{n+1}.jpg",
                                    content_type: "image/jpg")
  product.save!
end

3.times do |n|
  Size.create!(
    size: n+1
  )
end

20.times do
  price = Faker::Commerce.price(range: 1..100.0)
  ProductSize.create!(price: price,
                      product_id: Product.all.pluck(:id).sample,
                      size_id: Size.all.pluck(:id).sample
  )
end
