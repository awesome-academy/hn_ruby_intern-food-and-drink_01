class Size < ApplicationRecord
  has_many :product_sizes, dependent: :destroy
end
