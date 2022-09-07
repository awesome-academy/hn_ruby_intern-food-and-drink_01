class Product < ApplicationRecord
  has_many :product_sizes, dependent: :destroy
  has_many :sizes, through: :product_sizes
  has_one_attached :image
  belongs_to :category
  PRODUCT_ATTRS = %w( name unit_price description quantity
                      category_id image).freeze

  scope :asc_name, ->{order name: :asc}
  scope :lastest, ->{order created_at: :desc}
  scope :newest, ->{order(created_at: :desc).limit Settings.product.limit_new}
end
