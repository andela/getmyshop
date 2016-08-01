module ApplicationHelper
  def auth_link
    if logged_in
      render "user_profile"
    else
      link_to "SIGN IN", login_path, class: "white-text"
    end
  end

  def welcome_shop_owner
    "Welcome back, #{current_shop_owner.first_name}"
  end

  def welcome_user
    "Welcome back, #{current_user.first_name}"
  end
end
