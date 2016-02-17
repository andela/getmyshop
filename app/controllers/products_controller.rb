class ProductsController < ApplicationController
  def index
  end

  def show
    @product = Product.find_by_id(params[:id])
    category = @product.category
    @related_products = category.related_products(@product.id)
    @reviews = Review.product_reviews(@product.id)
  end
end
