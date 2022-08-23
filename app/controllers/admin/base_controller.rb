class Admin::BaseController < ApplicationController
  include SessionsHelper
  layout Settings.admin.layouts.link
  before_action :check_role_user

  private

  def check_role_user
    return if current_user.admin?

    flash[:danger] = t ".not_admin"
    redirect_to root_path
  end
end
