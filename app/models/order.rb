class Order < ApplicationRecord
  has_many :order_details, dependent: :destroy
  belongs_to :user
  before_save :update_subtotal

  enum status: {pending: 0, accepted: 1, complete: 2, canceled: 3}

  private

  def subtotal
    order_details.map{|od| (od.num * od.price)}.sum
  end

  def update_subtotal
    self[:total] = subtotal
  end
end
