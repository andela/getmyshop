class UsersController < ApplicationController
  def forgot
    render "forgot_password"
  end

  def process_email
    user = RegularUser.find_by_email(params[:email])
    if user
      flash[:success] = "An Email has been sent with instructions to"\
      " change your password"
      reset_code = [*"0".."9", *"a".."z", *"A".."Z"].sample(50).join
      RegularUser.update(user.id, reset_code: reset_code)
      UserMailer.reset_password(user.id, "Reset Your Password").deliver_now
    else
      flash[:error] = "No user found with this email"
    end
    redirect_to forgot_users_path
  end

  def reset_password
  end

  def reset
    user = RegularUser.find(params[:id])
    if user.reset_code == params[:reset_code]
      user.update_attributes password: params[:password], reset_code: nil
      flash[:notice] = "Password Successfully Changed."\
      " Sign in with new password"
      redirect_to login_path
    else
      flash[:notice] = "some error occured"
      render "forgot_password"
    end
  end

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
    @user = RegularUser.new(users_params)

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
