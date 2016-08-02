class ProductsController < ApplicationController
  before_action :set_product, only: [:show, :edit, :update]
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
      redirect_to dashboard_path, notice: MessageService.product_created
    else
      flash[:errors] = @product.errors.full_messages
      render :new
    end
  end

  def show
    category = @product.category
    @related_products = category.related_products(@product.id)
  end

  def edit
  end

  def update
    if @product.update(product_params)
      redirect_to dashboard_path, notice: MessageService.update_success
    else
      render :edit
    end
  end

  def review
    @product_to_rate = Product.find_by(id: params["item_id"])
  end

  def rate
    product_review = Review.new(rate_params)
    product_review.user_id = current_user.id
    product_review.save
  end

  def validate_product
    @product = Product.new(validate_product_params)
    if @product.valid?
      render json: { notice: "valid" }, status: 200
    else
      render json: @product.errors.full_messages, status: 422
    end
  end

  def destroy
    @product = Product.find_by(id: params[:id])

    if @product && @product.destroy
      render json: { notice: "Product Deleted" }, status: 200
    else
      render json: { error: "Unable to delete product" }, status: 404
    end
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

  def validate_product_params
    params.permit(:name, :description, :quantity, :brand, :size, :price, :image)
  end

  def assign_shop_owner
    @shop_owner = current_shop_owner
  end

  def set_product
    @product ||= Product.find_by(id: params[:id]).decorate
  end

  def rate_params
    params.permit(:title, :comment, :rating, :product_id)
  end
end
