module ProductsHelper
  def get_all_size product
    arr = Array.new
    product.sizes.each do |item|
      arr.push(item.size)
    end
    arr.to_s.gsub('"', '')
  end
end
