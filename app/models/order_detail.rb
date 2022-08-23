class OrderDetail < ApplicationRecord
  belongs_to :order
  belongs_to :product_size
  validates :price, presence: true, numericality: {greater_than: 0}

  def unit_price
    if persisted?
      self[:price]
    else
      product_size.price
    end
  end

  def total_price
    unit_price * num
  end

  private

  def finalize
    self[:price] = unit_price
    self[:total_money] = num * self[:price]
  end
end
