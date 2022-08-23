module CartsHelper
  def total_price
    product_sizes = ProductSize.by_ids @carts.keys
    product_sizes.reduce(0) do |total, product_s|
      total + product_s.product.unit_price * @carts[product_s.id.to_s].to_i
    end
  end

  def total_price_product product_size
    product_size.product.unit_price * @carts[product_size.id.to_s].to_i
  end

  def count_carts
    init_cart.present? ? init_cart.length : 0
  end

  def clean_carts
    user_id = session[:user_id]
    session["cart_#{user_id}"].each do |key, _value|
      session["cart_#{user_id}"].delete key unless Product.find_by id: key
    end
  end

  def init_cart
    user_id = session[:user_id]
    session["cart_#{user_id}"] ||= {}
    @carts = session["cart_#{user_id}"] ||= {}
    clean_carts
  end
end
