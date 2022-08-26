module CartsHelper
  def init_cart
    user_id = session[:user_id]
    session["cart_#{user_id}"] ||= {}
    @carts = session["cart_#{user_id}"] ||= {}
  end
end
