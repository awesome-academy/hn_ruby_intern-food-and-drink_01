class Order < ApplicationRecord
  has_many :order_details, dependent: :destroy
  belongs_to :user

  enum status: {pending: 0, accepted: 1, completed: 2, canceled: 3}

  ransacker :status, formatter: proc {|v| statuses[v]} do |parent|
    parent.table[:status]
  end

  ransacker :total_money, type: :integer do |p|
    p.table[:total_money]
  end

  ORDER_ATTRS = %w(name phone_num address note total_money).freeze

  validates :name,  presence: true,
            length: {maximum: Settings.user.name.name_max_length}
  validates :phone_num, presence: true,
            length: {is: Settings.user.phone.phone_length}
  validates :address, presence: true,
            length: {in: Settings.user.address.address_range_length}

  scope :lastest_order, ->{order created_at: :desc}

  def handle_order order_params
    ActiveRecord::Base.transaction do
      update!(status: order_params["status"])
      return true unless completed?

      ActiveRecord::Base.transaction(requires_new: true) do
        order_details.each do |order_detail|
          new_quantity = order_detail.product_size.product.quantity - order_detail.num
          update_order order_detail, new_quantity
          raise ActiveRecord::Rollback if new_quantity.negative?
        end
      end
    end
  rescue ActiveRecord::RecordInvalid => e
    errors.add(:base, e.message)
    false
  end

  private

  def update_order order_detail, new_quantity
    order_detail.product_size.product.update!(quantity: new_quantity)
  end
end
