class SessionsController < ApplicationController
  def new
  end

  def create
    if request.env["omniauth.auth"]
      oauth_user = OauthUser.new(request.env["omniauth.auth"])
      user = oauth_user.login_or_create
      session[:user_id] = user.id
      redirect_to root_path, notice: "Welcome back, #{current_user.first_name}"
    else
      redirect_to login_path
    end
  end
end
