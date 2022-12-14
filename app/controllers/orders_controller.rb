class OrdersController < ApplicationController
  before_action :authenticate_user!, only: %i(new create)
  before_action :init_cart, :load_product_sizes
  before_action :check_quantity_product_sizes, only: %i(new create)
  before_action :find_order, only: %i(show update)
  before_action :load_order_details, only: :show
  before_action :check_status_order, only: :update

  authorize_resource

  def index
    @q = Order.lastest_order.ransack(params[:q])
    @pagy, @orders = pagy(@q.result)
  end

  def show; end

  def new
    @order = current_user.orders.build
  end

  def create
    @order = current_user.orders.new order_params
    create_transaction
  end

  def update
    if @order.update(reason: params_reason[:reason], status: :canceled)
      flash[:success] = t ".cancle"
    else
      flash.now[:danger] = t ".cancle_fail"
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
  rescue StandardError
    flash[:danger] = t ".checkout_fail"
    redirect_to :new
  end

  def load_order_details
    @order_details = @order.order_details.includes(:product_size)
    return if @order_details

    flash[:danger] = t ".not_found"
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
end
