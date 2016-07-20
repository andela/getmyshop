class ShopsController < ApplicationController
  def dashboard
    @shop_owner = ShopOwner.find(params[:shop_owner_id])
    @shop = @shop_owner.shop
  end

  def new
    @shop_owner = ShopOwner.find(params[:shop_owner_id])
    @shop = Shop.new
  end

  def create
    @shop_owner = ShopOwner.find(params[:shop][:shop_owner_id])
    @shop = Shop.new(shop_params)
    if @shop.save
      @shop_owner.update(shop: @shop)
      redirect_to dashboard_path(@shop_owner), notice: shop_created
    else
      flash["errors"] = @shop.errors.full_messages
      render :new
    end
  end

  private

  def shop_params
    params.require(:shop).permit(
      :name, :url, :description, :address, :city, :state, :country, :phone
    )
  end
end
