class ProductsController < ApplicationController
  def index
  end

  def show
    @product = Product.find_by_id(params[:id])
    category = @product.category.id
    @related_products = Category.find(category).
                        products.order("RANDOM()").limit(3)
    redirect_to root_path if @product.nil?
  end
end
