class ShopOwnerSessionsController < ApplicationController
  def new
  end

  def create
    shop_owner = ShopOwner.find_by(email: params[:shop_owner_session][:email])
    return if shop_owner_is_nil?(shop_owner)
    if shop_owner.authenticate(params[:shop_owner_session][:password]) && shop_owner.active_status
      login_successful shop_owner
    else
      password_invalid
    end
  end

  def destroy
    @current_shop_owner = nil
    session.delete :shop_owner_id
    redirect_to root_path, notice: logout
  end

  private

  def shop_owner_is_nil?(shop_owner)
    return if shop_owner
    flash["errors"] = [login_failure]
    redirect_to shop_owner_login_path
  end

  def login_successful(shop_owner)
    session[:shop_owner_id] = shop_owner.id
    return redirect_to_user_intended unless session[:user_intended].nil?
    redirect_to dashboard_path(shop_owner), notice: welcome_shop_owner
  end

  def password_invalid
    flash["errors"] = [login_failure]
    redirect_to shop_owner_login_path
  end
end
