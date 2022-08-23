class ProductSize < ApplicationRecord
  has_many :order_details, dependent: :destroy
  belongs_to :product
  belongs_to :size

  scope :by_ids, ->(ids){where id: ids}
end
