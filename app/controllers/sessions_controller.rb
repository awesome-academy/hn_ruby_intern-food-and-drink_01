class SessionsController < ApplicationController
  def new; end

  def create
    user = User.find_by email: params[:session][:email].downcase
    if user&.authenticate(params[:session][:password])
      log_in user

      redirect
    else
      flash.now[:danger] = t ".invalid"
      render :new
    end
  end

  def destroy
    log_out if logged_in?

    redirect_to root_path
  end

  private
  def redirect
    if current_user.admin?
      redirect_back_or admin_root_path
    else
      redirect_back_or current_user
    end
  end
end
