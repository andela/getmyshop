class ProductsController < ApplicationController
  before_action :assign_shop_owner, only: [:new, :create]

  def index
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.create(product_params)
    @product.update(shop: @shop_owner.shop)
    if @product.errors.empty?
      redirect_to shop_products_path, notice: product_created
    else
      flash[:errors] = @product.errors.full_messages
      render :new
    end
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

  private

  def product_params
    params.require(:product).permit(
                                    :name,
                                    :description,
                                    :quantity,
                                    :brand,
                                    :size,
                                    :price,
                                    :image
                                  )
  end

  def assign_shop_owner
    @shop_owner = current_shop_owner
  end

  def rate_params
    params.permit(:title, :comment, :rating, :product_id)
  end
end
