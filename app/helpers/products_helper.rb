module ProductsHelper
  def get_all_size product
    product.sizes.map(&:size).join(", ")
  end
end
