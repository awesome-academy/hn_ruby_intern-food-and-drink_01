class ProductsController < ApplicationController
  def index
    @q = Product.asc_name.ransack(params[:q])
    if params[:sort]
      @pagy, @products = sort_by params[:sort]
    else
      @pagy, @products = pagy(@q.result)
      @sizes = Size.all
    end
  end

  def show
    @product = Product.find_by id: params[:id]
    return if @product

    flash[:danger] = t ".not_found"
    redirect_to root_path
  end

  def sort
    if params[:sort]
      @pagy, @products = sort_by params[:sort]
    else
      redirect_to root_path
    end
  end

  private

  def sort_by params
    case params.to_sym
    when :lastest
      pagy Product.lastest
    when :asc_name
      pagy Product.asc_name
    when :desc_name
      pagy Product.desc_name
    end
  end
end
