class Admin::OrdersController < Admin::BaseController
  before_action :find_order, only: :show
  before_action :load_order_details, only: :show

  def index
    @pagy, @orders = pagy Order.lastest_order
  end

  def show; end

  private

  def order_params
    params.require(:order).permit Order::status
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
end
