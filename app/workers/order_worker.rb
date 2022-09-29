class OrderWorker
  include Sidekiq::Worker

  def perform order_id
    @order = Order.find_by id: order_id
    return Sidekiq.logger.error(" Cannot found order") unless @order

    UserMailer.notification(@order).deliver_now
  end
end
