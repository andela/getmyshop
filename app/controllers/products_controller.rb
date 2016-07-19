class ProductsController < ApplicationController
  def index
  end

  def new
    @product = Product.new
    @shop_owner = ShopOwner.find(params[:shop_owner_id])
  end

  def create
    shop_owner = ShopOwner.find_by(id: params[:product][:shop_owner_id])
    @product = Product.new(product_params)
    if @product.save
      shop_owner.shop.products << @product
      redirect_to product_path(@product), notice: product_created
    else
      flash[:errors] = @product.errors
      render :new
    end
  end

  def show
    @product = Product.find_by(id: params[:id])
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
    allowed_params = [:name, :description, :quantity, :brand, :size, :price, :image]
    params.require(:product).permit(allowed_params)
  end

  def rate_params
    params.permit(:title, :comment, :rating, :product_id)
  end
end
