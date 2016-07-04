class ShopsController < ApplicationController
  

  def show
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
      redirect_to dashboard_path(@shop_owner), notice: "Shop Creation Successful"
      session[:shop_owner_id] = @shop_owner.id
    else
      flash["errors"] = @shop.errors.full_messages
      render :new
    end
  end

  def update
    respond_to do |format|
      if @shop.update(shop_params)
        format.html { redirect_to @shop, notice: 'Shop was successfully updated.' }
        format.json { render :show, status: :ok, location: @shop }
      else
        format.html { render :edit }
        format.json { render json: @shop.errors, status: :unprocessable_entity }
      end
    end
  end


  def destroy
    @shop.destroy
    respond_to do |format|
      format.html { redirect_to shops_url, notice: 'Shop was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

    # Never trust parameters from the scary internet, only allow the white list through.
    def shop_params
      params.require(:shop).permit(:name, :url, :description, :address, :city, :state, :country, :phone)
    end
end
