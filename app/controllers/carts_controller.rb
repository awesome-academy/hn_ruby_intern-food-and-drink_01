class CartsController < ApplicationController
  before_action :logged_in_user, only: %i(index create)
  before_action :load_product_size_by_foreign_key, only: %i(create)
  before_action :init_cart, only: %i(index create update destroy)
  before_action :load_product_sizes, only: :index
  before_action :load_product_size_by_primary_key, only: %i(update destroy)

  def index; end

  def create
    if check_quantity @product_size
      add_item @product_size, @num
      redirect_to product_path @product_size.product_id
    else
      flash[:danger] = t ".error_num"
      redirect_to root_path
    end
  end

  def update
    if @carts.key? params[:id]
      update_cart
    else
      flash[:danger] = t ".fail"
    end
    redirect_to carts_path
  end

  def destroy
    if @carts.key? params[:id]
      @carts.delete params[:id]
      flash[:success] = t ".success"
      user_id = session[:user_id]
      session["cart_#{user_id}"] = @carts
    else
      falsh[:danger] = t ".fail"
    end
    redirect_to carts_path
  end

  private

  def load_product_size_by_foreign_key
    @product_size = ProductSize.find_by product_id: params[:product_id],
                                        size_id: params[:size_id]
    return if @product_size

    flash[:danger] = t ".not_found"
    redirect_back_or root_path
  end

  def load_product_size_by_primary_key
    @product_size = ProductSize.find_by id: params[:id]
    return if @product_size

    flash[:danger] = t ".not_found"
    redirect_back_or root_path
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

  def update_cart
    if check_quantity @product_size
      @carts[params[:id]] = @num
      user_id = session[:user_id]
      session["cart_#{user_id}"] = @carts
      flash[:success] = t ".success"
    else
      flash[:danger] = t ".fail"
    end
  end
end
