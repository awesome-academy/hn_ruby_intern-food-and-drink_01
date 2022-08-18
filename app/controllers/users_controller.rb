class UsersController < ApplicationController
  before_action :logged_in_user, only: %i(edit update)
  before_action :correct_user, except: %i(new create)

  def show
    return if @user

    flash[:warning] = t ".not_found"
    redirect_to root_path
  end

  def new
    @user = User.new
  end

  def edit; end

  def update
    if @user.update(user_params)
      flash[:success] = t ".updated"
      redirect_to @user
    else
      flash[:danger] = t ".fail_update"
      render :edit
    end
  end

  def create
    @user = User.new user_params
    if @user.save
      flash[:success] = t ".welcome"
      redirect_to @user
    else
      flash[:danger] = t ".not_success"
      render :new
    end
  end

  private

  def user_params
    params.require(:user).permit(User::USER_ATTRS)
  end

  def logged_in_user
    return if logged_in?

    flash[:danger] = t ".not"
    redirect_to login_url
  end

  def correct_user
    @user = User.find_by id: params[:id]
    redirect_to root_path unless current_user?(@user)
  end
end
