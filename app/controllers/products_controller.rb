class ProductsController < ApplicationController
  def index
  end

  def show
    @product = Product.find_by_id(params[:id])
    redirect_to root_path if @product.nil?
  end
end
