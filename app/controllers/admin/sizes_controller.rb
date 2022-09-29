class Admin::SizesController < Admin::BaseController
  before_action :find_size, only: %i(edit update destroy)
  before_action :check_size_product, only: :destroy

  authorize_resource

  def index
    @q = Size.ransack(params[:q])
    @pagy, @sizes = pagy(@q.result, items: Settings.admin.category)
  end

  def new
    @size = Size.new
  end

  def create
    @size = Size.new size_params
    if @size.save
      flash[:success] = t ".create_success"
      redirect_to admin_sizes_path
    else
      flash[:danger] = t ".create_fail"
      render :new
    end
  end

  def edit; end

  def update
    if @size.update size_params
      flash[:success] = t ".update_success"
      redirect_to admin_sizes_path
    else
      flash[:danger] = t ".update_fail"
      render :edit
    end
  end

  def destroy
    if @size.destroy
      flash[:success] = t ".destroy_success"
    else
      flash[:danger] = t ".destroy_fail"
    end
    redirect_to admin_sizes_path
  end

  private

  def size_params
    params.require(:size).permit(:id, :size)
  end

  def find_size
    @size = Size.find_by id: params[:id]
    return if @size

    flash[:success] = t ".not_size"
    redirect_to admin_sizes_path
  end

  def check_size_product
    return if @size.products.blank?

    flash[:danger] = t ".have_product"
    redirect_to admin_sizes_path
  end
end
