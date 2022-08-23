class Product < ApplicationRecord
  has_many :product_sizes, dependent: :destroy
  has_one_attached :image
  belongs_to :category

  scope :asc_name, ->{order name: :asc}
  scope :newest, ->{order(created_at: :desc).limit 10}
end
