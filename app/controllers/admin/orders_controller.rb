class Admin::OrdersController < Admin::BaseController
  before_action :find_order, only: %i(show update)
  before_action :load_order_details, only: %i(show update)
  before_action :check_status_order, only: :update
  def index
    @q = Order.lastest_order.ransack(params[:q])
    @pagy, @orders = pagy(@q.result)
  end

  def show; end

  def update
    if @order.handle_order order_params
      flash[:success] = t ".update_success"
    else
      flash.now[:danger] = t ".update_fail"
    end
    redirect_to admin_orders_path
  end
  private

  def order_params
    params.require(:order).permit :status
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
    return if @order.pending? || @order.accepted?

    flash[:danger] = t ".danger"
    redirect_to admin_orders_path
  end
end
