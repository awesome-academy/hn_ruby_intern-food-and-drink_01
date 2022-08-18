class UsersController < ApplicationController
  before_action :logged_in_user, only: [:edit, :update]
  before_action :find_user, only: [:edit, :update]

  def show
    @user = User.find(params[:id])
    return if @user

    flash[:warning] = t ".not_found"
    redirect_to root_path
  end

  def new
    @user = User.new
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
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

  def find_user
    @user = User.find_by id: params[:id]
    redirect_to root_path unless current_user?(@user)
  end
end
