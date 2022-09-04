class Admin::ProductsController < Admin::BaseController
  before_action :load_category_size, only: %i(new create edit)
  before_action :find_product, only: %i(edit update destroy)
  def index
    @q = Product.lastest.ransack(params[:q])
    @pagy, @products = pagy(@q.result)
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
<<<<<<< HEAD
      flash[:success] = t ".success"
    else
      flash[:danger] = t ".not_success"
=======
      flash[:success] = "success"
    else
      flash[:danger] = "danger"
>>>>>>> admin add and index product
    end
    redirect_to admin_products_path
  end

  private
<<<<<<< HEAD
  def product_params
    params.require(:product).permit(Product::PRODUCT_ATTRS, size_ids: [])
=======

  def product_params
    params.require(:product).permit(:name, :unit_price, :description, :quantity, :category_id, :image , size_ids: [])
>>>>>>> admin add and index product
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

<<<<<<< HEAD
    flash[:danger] = t ".not_product"
=======
    flash[:danger] = "no exist product"
>>>>>>> admin add and index product
    redirect_to admin_products_path
  end
end
