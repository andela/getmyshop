class ShopOwnersController < ApplicationController
  def new
    @shop_owner = ShopOwner.new
  end

  def edit
  end

  def shop_owner_activate
    shop_owner = ShopOwner.token_match(params[:token])
    if shop_owner && shop_owner.update(verified: true)
      session[:shop_owner_id] = shop_owner.id
      redirect_to shop_new_path(shop_owner),
                  notice: MessageService.account_activated
    else
      redirect_to root_path, notice: MessageService.activation_failed
    end
  end

  def create
    @shop_owner = ShopOwner.new(shop_owner_params)
    if @shop_owner.save
      UserMailer.welcome_shop_owner(@shop_owner, MessageService.welcome).
        deliver_now
      redirect_to login_path, notice: MessageService.account_created
    else
      flash["errors"] = @shop_owner.errors.full_messages
      render :new
    end
  end

  private

  def shop_owner_params
    params.require(:shop_owner).permit(allowed_attributes)
  end

  def allowed_attributes
    [:first_name, :last_name, :phone, :email, :password, :password_confirmation]
  end
end
