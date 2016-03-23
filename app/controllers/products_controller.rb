class ProductsController < ApplicationController
  def index
  end

  def show
    @product = Product.find_by_id(params[:id])
    category = @product.category
    @related_products = category.related_products(@product.id)
  end

  def review
    @product_to_rate = Product.find_by(id: params["item_id"])
  end

  def rate
    product = Product.find_by(id: params["item_id"])
    reviews = Review.new(rate_params)
  end

  def rate_params
     params.permit(:title, :comment, :rating, :product_id)
  end
end
