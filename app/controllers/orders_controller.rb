class OrdersController < ApplicationController
  before_action :logged_in_user, only: %i(new create)
  before_action :init_cart
  before_action :load_product_sizes
  before_action :check_quantity_product_sizes, only: %i(new create)
  def new
    @order = current_user.orders.build
  end

  def create
    @order = current_user.orders.new order_params
    if @order.valid?
      create_transaction
    else
      flash[:danger] = t ".fail"
      render :new
    end
  end

  private

  def order_params
    params.require(:order).permit Order::ORDER_ATTRS
  end

  def create_order_detail
    @product_sizes.each do |item|
      product_size_id = item.id.to_i
      @order.order_details.create!(
        product_size_id: product_size_id,
        num: @carts[product_size_id.to_s],
        price: item.product.unit_price,
        total_money: @carts[product_size_id.to_s] * item.product.unit_price
      )
    end
  end

  def create_transaction
    ActiveRecord::Base.transaction do
      @order.save!
      create_order_detail
      clear_carts
      flash[:success] = t ".success"
      redirect_to root_path
    end
  rescue
    flash[:danger] = t ".checkout_fail"
    redirect_to carts_path
  end
end
