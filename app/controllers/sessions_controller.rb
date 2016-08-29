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
      process_form_login "RegularUser"
    end
  end

  def shop_owner_create
    process_form_login "ShopOwner"
  end

  def destroy
    logout_user current_user
  end

  def shop_owner_destroy
    logout_user current_shop_owner
  end

  private

  def logout_user(_user)
    _user = nil
    session.delete :user_id
    redirect_to root_path, notice: MessageService.logout
  end

  def process_form_login(model)
    user = model.constantize.find_by(email: params[:session][:email])
    return if user_is_nil?(user, model)

    authenticated = user.authenticate(params[:session][:password])
    if authenticated && user.verified && user.active
      login_successful(user, model)
    else
      password_invalid model
    end
  end

  def user_is_nil?(user, model)
    return if user
    flash["errors"] = MessageService.login_failure

    redirect_to_path model
  end

  def login_successful(user, model)
    session[:user_id] = user.id
    return redirect_to_user_intended unless session[:user_intended].nil?

    if model == "RegularUser"
      redirect_to root_path, notice: welcome_user
    else
      redirect_to dashboard_path, notice: welcome_shop_owner
    end
  end

  def password_invalid(model)
    flash["errors"] = MessageService.login_failure

    redirect_to_path model
  end

  def redirect_to_path(model)
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
