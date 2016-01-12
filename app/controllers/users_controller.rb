class UsersController < ApplicationController
  def index
  end

  def show
  end

  def new
    if flash["user"].nil?
      @user = User.new
    else
      @user = User.new(flash["user"])
    end
  end

  def create
    @user = User.new(users_params)

    if @user.save
      UserMailer.welcome(@user.id, "Welcome To GetMyShop").deliver_now
      flash["toast-message"] = true
      redirect_to root_path, notice: "Welcome, #{@user.first_name}"
    else

      flash["errors"] = @user.errors.full_messages
      flash["user"] = @user
      redirect_to :back
    end
  end

  def activate
  end

  def users_params
    params.require(:user).permit(:first_name, :last_name, :email, :password)
  end
end
