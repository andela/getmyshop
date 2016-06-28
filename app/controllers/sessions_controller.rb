require_relative "../helpers/message_helper"

class SessionsController < ApplicationController
  include MessageHelper
  
  def new
  end

  def shop_login
  end

  def shop_login_create
    login_user(dashboard_path, shop_login_path)
  end

  def create
    if request.env["omniauth.auth"]
      oauth_user = OauthUser.new(request.env["omniauth.auth"])
      user = oauth_user.login_or_create
      session[:user_id] = user.id

      return redirect_to_user_intended unless session[:user_intended].nil?
      redirect_to root_path, notice: welcome_user
    else
      process_form_login
    end
  end

  def destroy
    @current_user = nil
    session.delete :user_id
    redirect_to root_path, notice: logout
  end

  private 

  def process_form_login
    login_user(root_path, login_path)
  end

  def login_user(login_success_path, login_failure_path)
    user = RegularUser.find_by email: params[:session][:email]
    return if user_is_nil?(user)
    if user.authenticate(params[:session][:password]) && user.active
      login_successful user
      redirect_to login_success_path, notice: welcome_user
    else
      password_invalid
      redirect_to login_failure_path
    end
  end

  def user_is_nil?(user)
    return if user
    flash["errors"] = [invalid_login]
    redirect_to login_path

    true
  end

  def login_successful(user)
    session[:user_id] = user.id
    return redirect_to_user_intended unless session[:user_intended].nil?
  end

  def password_invalid
    flash["errors"] = [invalid_login]
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
