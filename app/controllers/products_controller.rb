class ProductsController < ApplicationController
  def index
    @pagy, @products = pagy Product.asc_name
  end

  def show
    @product = Product.find_by id: params[:id]
  end
end
