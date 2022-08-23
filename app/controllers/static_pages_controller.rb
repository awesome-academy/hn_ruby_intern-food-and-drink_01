class StaticPagesController < ApplicationController
  def home
    @pagy, @products = pagy Product.newest
  end
end
