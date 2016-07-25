class ShopsController < ApplicationController
  before_action :assign_shop_owner
  def show
    @shop = @shop_owner.shop
    @product = Product.new
  end

  def new
    @shop = Shop.new
  end

  def products
    @products = @shop_owner.shop.products
  end

  def create
    @shop = Shop.new(shop_params)
    
    if @shop.save
      @shop_owner.update(shop: @shop)
      redirect_to dashboard_path(@shop_owner),
                  notice: MessageService.shop_created
    else
      flash["errors"] = @shop.errors.full_messages
      render :new
    end
  end

  private

  def assign_shop_owner
    @shop_owner = current_shop_owner
  end

  def shop_params
    params.require(:shop).permit(
      :name, :url, :description, :address, :city, :state, :country, :phone
    )
  end
end
