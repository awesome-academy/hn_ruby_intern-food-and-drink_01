class Order < ApplicationRecord
  has_many :order_details, dependent: :destroy
  belongs_to :user

  enum status: {pending: 0, accepted: 1, completed: 2, canceled: 3}

  ransacker :created_at_date, type: :date do
    Arel.sql("date(created_at)")
  end

  ORDER_ATTRS = %w(name phone_num address note total_money).freeze

  validates :name,  presence: true,
            length: {maximum: Settings.user.name.name_max_length}
  validates :phone_num, presence: true,
            length: {is: Settings.user.phone.phone_length}
  validates :address, presence: true,
            length: {in: Settings.user.address.address_range_length}

  scope :lastest_order, ->{order created_at: :desc}
  after_save :send_mail_notify

  def send_mail_notify
    OrderWorker.perform_async id
  end

  def handle_order order_params
    ActiveRecord::Base.transaction do
      update!(status: order_params["status"], reason: order_params["reason"])
      return true unless completed?

      order_details.each do |order_detail|
        new_quan = order_detail.product_size.product.quantity - order_detail.num
        update_order order_detail, new_quan
        raise ActiveRecord::Rollback if new_quan.negative?
      end
    end
  rescue StandardError => e
    "ERROR: #{e.message}"
  end

  private

  def update_order order_detail, new_quantity
    order_detail.product_size.product.update!(quantity: new_quantity)
  end
end
