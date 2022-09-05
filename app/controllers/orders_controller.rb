class OrdersController < ApplicationController
  before_action :logged_in_user, only: %i(new create)
  before_action :init_cart
  before_action :load_product_sizes
  before_action :check_quantity_product_sizes, only: %i(new create)
  before_action :find_order, only: %i(show update)
  before_action :load_order_details, only: :show
  before_action :check_status_order, only: :update
  before_action :check_carts, only: :new

  def index
    @pagy, @orders = pagy Order.lastest_order
  end

  def show; end

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

  def update
    if @order.update(reason: params_reason[:reason], status: :canceled)
      flash[:success] = "Huy don hang thanh cong"
    else
      flash.now[:danger] = "Don hang da duoc giao"
    end
    redirect_to orders_url
  end

  private

  def order_params
    params.require(:order).permit Order::ORDER_ATTRS
  end

  def params_reason
    params.require(:order).permit :reason
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

  def load_order_details
    @order_details = @order.order_details.includes(:product_size)
    return if @order_details

    flash[:danger] =  t ".not_found"
    redirect_to orders_url
  end

  def find_order
    @order = Order.find_by id: params[:id]

    return if @order

    flash[:warning] = t ".not_found"
    redirect_to root_path
  end

  def check_status_order
    return if @order.pending?

    flash[:danger] = t ".danger"
    redirect_to orders_path
  end

  def check_carts
    return unless @carts.blank?

    flash[:danger] = "cart is blank"
    redirect_to root_path
  end
end
