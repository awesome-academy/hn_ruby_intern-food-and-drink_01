class ProductsController < ApplicationController
  def index
    @pagy, @products = pagy Product.asc_name
    @sizes = Size.asc_name
  end

  def show
    @product = Product.find_by id: params[:id]
    return if @product

    flash[:danger] = t ".not_found"
    redirect_to root_path
  end
end
