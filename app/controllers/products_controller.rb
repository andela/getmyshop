class ProductsController < ApplicationController
  def index
  end

  def new
    @product = Product.new
    @shop_owner = ShopOwner.find(params[:shop_owner_id])
  end

  def create
    @shop_owner = ShopOwner.find_by(id: params[:product][:shop_owner_id])
    @product = Product.new(product_params)
    if @product.save
      @shop_owner.shop.products << @product
      redirect_to shop_products_path(@shop_owner), notice: product_created
    else
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
    params.require(:product).permit(:name,
                                    :description,
                                    :quantity,
                                    :brand,
                                    :size,
                                    :price,
                                    :image)
  end

  def rate_params
    params.permit(:title, :comment, :rating, :product_id)
  end
end
