class Admin::ProductsController < Admin::BaseController
  before_action :load_category_size, only: %i(new create edit)
  before_action :find_product, only: %i(edit update destroy)
  def index
    @pagy, @products = pagy Product.lastest
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new product_params
    if @product.save
      flash[:success] = t ".success"
      redirect_to admin_products_path
    else
      flash[:danger] = "not success"
      render :new
    end
  end

  def update
    if @product.update product_params
      flash[:success] = "Product updated"
      redirect_to admin_products_path
    else
      flash[:danger] = "danger"
      render :edit
    end
  end

  def destroy
    if @product.destroy
      flash[:success] = "success"
    else
      flash[:danger] = "danger"
    end
    redirect_to admin_products_path
  end

  private

  def product_params
    params.require(:product).permit(:name, :unit_price, :description, :quantity, :category_id, :image , size_ids: [])
  end

  def size_params
    params.require(:product).permit(size_ids: [])
  end

  def load_category_size
    @categories = Category.all
    @sizes = Size.all
  end

  def find_product
    @product = Product.find_by id: params[:id]
    return if @product

    flash[:danger] = "no exist product"
    redirect_to admin_products_path
  end
end
