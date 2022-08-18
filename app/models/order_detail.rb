class OrderDetail < ApplicationRecord
  belongs_to :order
  belongs_to :product_size
end
