class Admin::SizesController < Admin::BaseController
  def index
    @q = Size.all.ransack(params[:q])
    @pagy, @sizes = pagy(@q.result, items: 8)
  end

  def new
    @size = Size.new
  end

  def create
    @size = Size.new size_params
  if @size.save
    flash[:success] = "welcome"
    redirect_to admin_sizes_path
  else
    flash[:danger] = "danger"
    render :new
  end
  end

  def edit
    @size = Size.find(params[:id])
  end

  def update
    @size = Size.find(params[:id])
    if @size.update size_params
      flash[:success] = "Profile updated"
      redirect_to admin_sizes_path
    else
      flash[:danger] = "danger"
      render :edit
    end
  end

  def destroy
    @size = Size.find_by id: params[:id]
    if @size.destroy
      flash[:success] = "success"
    else
      flash[:danger] = "danger"
    end
    redirect_to admin_sizes_path
  end

  private

  def size_params
    params.require(:size).permit(:id, :size)
  end

end
