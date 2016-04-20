class ProductsController < ApplicationController
  def index
  end

  def show
    @product = Product.find_by(id: params[:id]).decorate
    category = @product.category
    @related_products = category.related_products(@product.id)
  end

  def review
    @product_to_rate = Product.find_by(id: params["item_id"])
  end

  def rate
    product_review = Review.new(rate_params)
    product_review.user_id = current_user.id
    product_review.save
  end

  def rate_params
    params.permit(:title, :comment, :rating, :product_id)
  end
end
