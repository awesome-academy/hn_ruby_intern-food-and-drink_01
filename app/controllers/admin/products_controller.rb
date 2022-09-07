class Admin::ProductsController < Admin::BaseController
  before_action :load_category_size, only: %i(new create edit)
  before_action :find_product, only: %i(edit update destroy)
  def index
    @pagy, @products = pagy Product.includes(:sizes).lastest
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
      flash[:danger] = t ".not_success"
      render :new
    end
  end

  def edit; end

  def update
    if @product.update product_params
      flash[:success] = t ".success"
      redirect_to admin_products_path
    else
      flash[:danger] = t ".not_success"
      render :edit
    end
  end

  def destroy
    if @product.destroy
      flash[:success] = t ".success"
    else
      flash[:danger] = t ".not_success"
    end
    redirect_to admin_products_path
  end

  private
  def product_params
    params.require(:product).permit(Product::PRODUCT_ATTRS, size_ids: [])
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

    flash[:danger] = t ".not_product"
    redirect_to admin_products_path
  end
end
