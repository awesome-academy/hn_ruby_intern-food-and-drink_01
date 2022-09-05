class Product < ApplicationRecord
  has_many :product_sizes, dependent: :destroy
  has_many :sizes, through: :product_sizes
  has_one_attached :image
  belongs_to :category

  ransacker :price_money, type: :integer do |p|
    p.table[:unit_price]
  end

  validates :name, presence: true,
            length: {maximum: 40}
  validates :unit_price, presence: true
  validates :description, presence: true
  validates :image, presence:true
  scope :asc_name, ->{order name: :asc}
  scope :lastest, ->{order created_at: :desc}
  scope :newest, ->{order(created_at: :desc).limit Settings.product.limit_new}
end
