class UsersController < ApplicationController
  def forgot
    render "forgot_password"
  end

  def process_email
    user = RegularUser.find_by_email(params[:email])
    if user
      flash[:success] = change_password
      reset_code = [*"0".."9", *"a".."z", *"A".."Z"].sample(50).join
      RegularUser.update(user.id, reset_code: reset_code)
      UserMailer.reset_password(user.id, password_reset).deliver_now
    else
      flash[:error] = user_not_found
    end

    redirect_to forgot_users_path
  end

  def reset_password
  end

  def reset
    user = RegularUser.find(params[:id])

    if user.reset_code == params[:reset_code]
      user.update_attributes password: params[:password], reset_code: nil
      flash[:notice] = password_changed
      redirect_to login_path
    else
      flash[:notice] = error_occured
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
      UserMailer.welcome(@user.id, welcome).deliver_now
      session[:user_id] = @user.id
      redirect_to root_path, notice: welcome_user
    else
      flash["errors"] = @user.errors.full_messages
      flash["user"] = @user
      redirect_to :back
    end
  end

  def activate
    user = User.token_match(params[:user_id], params[:activation_token]).first

    if user && user.update(verified: true)
      session[:user_id] = user.id
      redirect_to root_path, notice: account_activated
    else
      redirect_to root_path, notice: activation_failed
    end
  end

  def account
  end

  def edit
    @user = User.find_by(id: params[:id])
  end

  def addresses
    @user_addresses = current_user.addresses
  end

  def update
    user = User.find_by(id: params[:id])
    user.update(users_params)
    redirect_to account_users_path, notice: account_updated
  end

  def destroy
    current_user.update(active: false)
    logout
  end

  def logout
    session.delete :user_id
    redirect_to root_path, notice: account_deactivated
  end

  def users_params
    params.require(:user).permit(:first_name, :last_name, :email, :password)
  end
end
