class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper
  include Pagy::Backend
  include CartsHelper
  include ProductsHelper

  before_action :set_locale, :init_cart, :load_product_sizes

  private

  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end

  def default_url_options
    {locale: I18n.locale}
  end

  def logged_in_user
    return if logged_in?

    store_location
    flash[:danger] = t ".please_login"
    redirect_to login_path
  end

  def load_product_sizes
    @product_sizes = ProductSize.by_ids @carts.keys
  end
end
