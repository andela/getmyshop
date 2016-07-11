class ShopOwnersController < ApplicationController
  def new
    @shop_owner = ShopOwner.new
  end

  def edit
  end

  def shop_owner_activate
    shop_owner = ShopOwner.token_match(
      params[:shop_owner_id], params[:activation_token]
    ).first

    if shop_owner && shop_owner.update(active_status: true)
      session[:shop_owner_id] = shop_owner.id
      shop_path = shop_new_path(shop_owner)
      redirect_to shop_path, notice: "Account activated successfully."
    else
      redirect_to root_path, notice: "Unable to activate account. "\
      "If you copied the link, make sure you copied it correctly."
    end
  end

  def create
    @shop_owner = ShopOwner.new(shop_owner_params)
    if @shop_owner.save
      UserMailer.welcome_shop_owner(@shop_owner.id, "Welcome To GetMyShop").
        deliver_now
      redirect_to login_path, notice: "An activation link has been sent to"\
      "your email, click on it to activate account"
    else
      flash["errors"] = @shop_owner.errors.full_messages
      render :new
    end
  end

  private

  def shop_owner_params
    allowed_attributes = [:first_name, :last_name,
                          :phone, :email, :password, :password_confirmation]
    params.require(:shop_owner).permit(allowed_attributes)
  end
end
