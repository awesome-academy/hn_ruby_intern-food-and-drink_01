class Product < ApplicationRecord
  has_many :product_sizes, dependent: :destroy
  has_many :sizes, through: :product_sizes
  has_one_attached :image
  belongs_to :category
  PRODUCT_ATTRS = %w( name unit_price description quantity
                      category_id image).freeze

  ransacker :price_money, type: :integer do |p|
    p.table[:unit_price]
  end

  validates :name, presence: true,
            length: {maximum: 40}
  validates :unit_price, presence: true, numericality: {greater_than_or_equal_to: Settings.min_quantity}
  validates :description, presence: true
  validates :image, presence: true
  validates :quantity, presence: true, numericality: {greater_than_or_equal_to: Settings.min_quantity,
    only_integer: true}
  scope :asc_name, ->{order name: :asc}
  scope :desc_name, ->{order name: :desc}
  scope :lastest, ->{order created_at: :desc}
  scope :newest, ->{order(created_at: :desc).limit Settings.product.limit_new}
end
