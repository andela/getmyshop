class ShopsController < ApplicationController
  layout "dashboard_layout", only: [:products, :orders, :show, :edit]

  before_action :assign_shop_owner
  before_action :set_shop, only: [:update, :edit, :orders, :products, :show]

  def show
    @shop = @shop_owner.shop
    @product = Product.new
  end

  def new
    @shop = Shop.new
  end

  def edit
  end

  def update
    if @shop.update shop_params
      redirect_to edit_shop_path(@shop),
                  notice: MessageService.account_updated
      return
    end
    flash[:errors] = @shop.errors.full_messages
    redirect_to edit_shop_path(@shop)
  end

  def products
    @products = @shop_owner.shop.products
  end

  def create
    @shop = Shop.new(shop_params)

    if @shop.save
      @shop_owner.update(shop: @shop)
      redirect_to dashboard_path,
                  notice: MessageService.shop_created
    else
      flash["errors"] = @shop.errors.full_messages
      render :new
    end
  end

  def orders
    filtered_orders = @shop.orders.filter(params[:status])
    @orders = filtered_orders.paginate(page: params[:page], per_page: 15)
  end

  private

  def assign_shop_owner
    @shop_owner = current_shop_owner
  end

  def set_shop
    @shop = current_shop_owner.shop
  end

  def shop_params
    params.require(:shop).permit(
      :name, :url, :description, :address, :city, :state, :country, :phone
    )
  end
end
