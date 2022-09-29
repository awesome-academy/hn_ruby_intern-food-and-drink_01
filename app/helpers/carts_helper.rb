module CartsHelper
  def total_price
    product_sizes = ProductSize.by_ids @carts.keys
    product_sizes.reduce(0) do |total, product_s|
      total + product_s.product.unit_price * @carts[product_s.id.to_s].to_i
    end
  end

  def total_price_product id
    if product_size = ProductSize.find_by(id: id)
      product_size.product.unit_price * @carts[product_size.id.to_s].to_i
    else
      flash[:danger] = I18n.t ".carts.danger_book"
      redirect_to carts_path
    end
  end

  def count_carts
    init_cart.present? ? init_cart.length : 0
  end

  def clean_carts
    user_id = session[:user_id]
    session["cart_#{user_id}"].each do |key, _value|
      unless ProductSize.find_by id: key.to_i
        session["cart_#{user_id}"].delete key
      end
    end
  end

  def clear_carts
    user_id = session[:user_id]
    session["cart_#{user_id}"] = {}
  end

  def init_cart
    user_id = session[:user_id]
    session["cart_#{user_id}"] ||= {}
    @carts = session["cart_#{user_id}"] ||= {}
    clean_carts
  end

  def check_quantity_product_sizes
    @product_sizes.each do |item|
      product_id = item.id
      quantity = @carts[product_id.to_s]
      if quantity > item.product.quantity
        flash[:danger] = t("hepler.product_stock", prod_name: item.product.name)
        redirect_to root_path
      end
    end
  end
end
