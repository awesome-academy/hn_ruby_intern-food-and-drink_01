class Admin::CategoriesController < Admin::BaseController
  def index
    @q = Category.all.ransack(params[:q])
    @pagy, @categories = pagy(@q.result, items: 8)
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new category_params
  if @category.save
    flash[:success] = "welcome"
    redirect_to admin_categories_path
  else
    flash[:danger] = "danger"
    render :new
  end
  end

  def edit
    @category = Category.find(params[:id])
  end

  def update
    @category = Category.find(params[:id])
    if @category.update category_params
      flash[:success] = "Profile updated"
      redirect_to admin_categories_path
    else
      flash[:danger] = "danger"
      render :edit
    end
  end

  def destroy
    @category = Category.find_by id: params[:id]
    if @category.destroy
      flash[:success] = "success"
    else
      flash[:danger] = "danger"
    end
    redirect_to admin_categories_path
  end

  private

  def category_params
    params.require(:category).permit(:id, :name)
  end

end
