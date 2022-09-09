class Admin::CategoriesController < Admin::BaseController
  before_action :find_category, only: %i(edit update destroy)
  before_action :check_category_product, only: :destroy
  def index
    @q = Category.ransack(params[:q])
    @pagy, @categories = pagy(@q.result, items: Settings.admin.category)
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new category_params
    if @category.save
      flash[:success] = t ".create_success"
      redirect_to admin_categories_path
    else
      flash[:danger] = t ".create_fail"
      render :new
    end
  end

  def edit; end

  def update
    if @category.update category_params
      flash[:success] = t ".update_success"
      redirect_to admin_categories_path
    else
      flash[:danger] = t ".update_fail"
      render :edit
    end
  end

  def destroy
    if @category.destroy
      flash[:success] = t ".destroy_success"
    else
      flash[:danger] = t ".destroy_fail"
    end
    redirect_to admin_categories_path
  end

  private

  def category_params
    params.require(:category).permit(:id, :name)
  end

  def find_category
    @category = Category.find_by id: params[:id]
    return if @category

    flash[:success] = t ".not_category"
    redirect_to admin_categories_path
  end

  def check_category_product
    return if @category.products.blank?

    flash[:danger] = t ".have_product"
    redirect_to admin_categories_path
  end
end
