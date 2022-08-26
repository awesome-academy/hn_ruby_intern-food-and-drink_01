class CartsController < ApplicationController
  before_action :logged_in_user, :init_cart, only: %i(index create)
  before_action :load_product_size, only: :create

  def index; end

  def create
    if check_quantity @product_size
      add_item @product_size, @num
    else
      flash[:danger] = t ".error_num"
    end
    redirect_to product_path params[:product_id]
  end

  private

  def load_product_size
    @product_size = ProductSize.find_by product_id: params[:product_id],
                                        size_id: params[:size_id]
    return if @product_size

    flash[:danger] = t ".not_found"
    redirect_to product_path params[:product_id]
  end

  def check_quantity product_size
    @num = params[:num].to_i
    @num <= product_size.product.quantity && @num > Settings.carts.min_quantity
  end

  def add_item product_size, num
    if @carts.key? product_size.id.to_s
      @carts[product_size.id.to_s] += num
    else
      @carts[product_size.id.to_s] = num
    end
    flash[:success] = t ".success"
  end
end
