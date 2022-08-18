class Order < ApplicationRecord
  has_many :order_details, dependent: :destroy
  belongs_to :user

  enum status: {pending: 0, accepted: 1, complete: 2, canceled: 3}
end
