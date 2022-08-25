class ProductSize < ApplicationRecord
  has_many :order_details, dependent: :nullify
  belongs_to :product
  belongs_to :size
end
