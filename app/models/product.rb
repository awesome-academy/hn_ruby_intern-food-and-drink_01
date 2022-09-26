class Product < ApplicationRecord
  has_many :product_sizes, dependent: :destroy
  has_many :sizes, through: :product_sizes
  has_one_attached :image
  belongs_to :category

  ransacker :created_at_date, type: :date do
    Arel.sql("date(created_at)")
  end

  PRODUCT_ATTRS = %w( name unit_price description quantity
                      category_id image).freeze

  validates :name,  presence: true,
                    length: {maximum: Settings.product.name.name_max_length}
  validates :unit_price, presence: true
  validates :description, presence: true,
                          length: {maximum: Settings.product.description.length}
  validates :image, presence: true

  scope :asc_name, ->{order name: :asc}
  scope :desc_name, ->{order name: :desc}
  scope :lastest, ->{order created_at: :desc}
  scope :newest, ->{order(created_at: :desc).limit Settings.product.limit_new}
end
