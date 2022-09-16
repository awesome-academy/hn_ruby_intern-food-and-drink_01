class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include Pagy::Backend
  include CartsHelper
  include ProductsHelper

  before_action :set_locale, :init_cart, :load_product_sizes
  before_action :configure_permitted_parameters, if: :devise_controller?

  private

  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end

  def default_url_options
    {locale: I18n.locale}
  end

  def load_product_sizes
    @product_sizes = ProductSize.by_ids @carts.keys
  end

  def configure_permitted_parameters
    added_attrs = %i( name email password password_confirmation remember_me
                      address phone_num)
    added_attrs_update = %i(name email password password_confirmation
                            remember_me address phone_num)
    devise_parameter_sanitizer.permit :sign_up, keys: added_attrs
    devise_parameter_sanitizer.permit :account_update, keys: added_attrs_update
  end
end
