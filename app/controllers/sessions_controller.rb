class SessionsController < ApplicationController
  def new
  end

  def shop_owner_login
  end

  def create
    if request.env["omniauth.auth"]
      oauth_user = OauthUser.new(request.env["omniauth.auth"])
      user = oauth_user.login_or_create
      session[:user_id] = user.id

      return redirect_to_user_intended unless session[:user_intended].nil?
      redirect_to root_path, notice: welcome_user
    else
      process_form_login("RegularUser")
    end
  end

  def shop_owner_create
    process_form_login("ShopOwner")
  end

  def destroy
    @current_user = nil
    session.delete :user_id
    redirect_to login_path, notice: logout
  end

  def shop_owner_destroy
    @current_shop_owner = nil
    session.delete :shop_owner_id
    redirect_to shop_owner_login_path, notice: logout
  end

  private

  def process_form_login(model)
    user = model.constantize.find_by(email: params[:session][:email])
    return if user_is_nil?(user, model)

    if user.authenticate(params[:session][:password]) &&
       user.verified &&
       user.active
      login_successful(user, model)
    else
      password_invalid(model)
    end
  end

  def user_is_nil?(user, model)
    return if user
    flash["errors"] = [login_failure]

    if model == "RegularUser"
      redirect_to login_path
    else
      redirect_to shop_owner_login_path
    end
  end

  def login_successful(user, model)
    session[:user_id] = user.id
    return redirect_to_user_intended unless session[:user_intended].nil?

    if model == "RegularUser"
      redirect_to root_path, notice: welcome_user
    else
      redirect_to dashboard_path(user.id), notice: welcome_shop_owner
    end
  end

  def password_invalid(model)
    flash["errors"] = [login_failure]

    if model == "RegularUser"
      redirect_to login_path
    else
      redirect_to shop_owner_login_path
    end
  end

  def redirect_to_user_intended
    destination, origin, method = get_intended_parameters
    session[:user_intended] = nil
    return redirect_to destination if method.casecmp("GET") == 0
    redirect_to origin unless origin.nil?
  end

  def get_intended_parameters
    destination = session[:user_intended]["request_path"]
    origin = session[:user_intended]["request_referer"]
    method = session[:user_intended]["request_method"]

    [destination, origin, method]
  end
end
