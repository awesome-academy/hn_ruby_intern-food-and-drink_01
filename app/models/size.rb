class Size < ApplicationRecord
  has_many :product_sizes, dependent: :destroy
  enum size: {M: 1, L: 2, XL: 3}
end
