class ProductSize < ApplicationRecord
  has_many :order_details, dependent: :nullity
  belongs_to :product
  belongs_to :size
end
