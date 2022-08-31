class Admin::ProductsController < Admin::BaseController
  def index
    @pagy, @products = pagy Product.lastest
  end


  def update
  end

  def destroy

  end
end
