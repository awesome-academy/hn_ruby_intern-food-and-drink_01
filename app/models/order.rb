class Order < ApplicationRecord
  has_many :order_details, dependent: :destroy
  belongs_to :user

  enum status: {pending: 0, accepted: 1, complete: 2, canceled: 3}

  ORDER_ATTRS = %w(name phone_num address note total_money).freeze

  validates :name,  presence: true,
            length: {maximum: Settings.user.name.name_max_length}
  validates :phone_num, presence: true,
            length: {is: Settings.user.phone.phone_length}
  validates :address, presence: true,
            length: {in: Settings.user.address.address_range_length}
end
