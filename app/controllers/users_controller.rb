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
    @user = flash["user"] ? User.new(flash["user"]) : User.new
  end

  def create
    @user = RegularUser.new(users_params)

    if @user.save
      UserMailer.welcome(@user.id, "Welcome To GetMyShop").deliver_now
      session[:user_id] = @user.id
      redirect_to root_path, notice: "Welcome, #{current_user.first_name}"
    else
      flash["errors"] = @user.errors.full_messages
      flash["user"] = @user
      redirect_to :back
    end
  end

  def activate
    user = User.token_match(params[:user_id], params[:activation_token]).first

    if user && user.update(active_status: true)
      session[:user_id] = user.id
      redirect_to root_path, notice: "Account activated successfully."
    else
      redirect_to root_path, notice: "Unable to activate account. "\
      "If you copied the link, make sure you copied it correctly."
    end
  end

  def account
  end

  def edit
  end

  def addresses
    @user_addresses = current_user.addresses
  end

  def update
    current_user.update(users_params)
    redirect_to account_users_path, notice: "Account Updated"
  end

  def destroy
    current_user.destroy
    logout
  end

  def logout
    session.delete :user_id
    redirect_to root_path, notice: "Account Deactivated"
  end

  def users_params
    params.require(:user).permit(:first_name, :last_name, :email, :password)
  end
end
