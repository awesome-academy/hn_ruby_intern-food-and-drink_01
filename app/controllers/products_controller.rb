class ProductsController < ApplicationController
  def index

    

    @q = Product.asc_name.ransack(params[:q])
    @pagy, @products = pagy(@q.result)
    @sizes = Size.all
  end

  def show
    @product = Product.find_by id: params[:id]
    return if @product

    flash[:danger] = t ".not_found"
    redirect_to root_path
  end
end
