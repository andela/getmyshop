module MessageHelper
  def account_activated
    "Account activated successfully."
  end

  def activation_failed
    "Unable to activate account. "\
    "If you copied the link, make sure you copied it correctly."
  end

  def welcome
    "Welcome To GetMyShop"
  end

  def account_created
    "An activation link has been sent to "\
    "your email, click on it to activate account"
  end

  def shop_created
    "Shop Creation Successful"
  end

  def login_failure
    "Email or Password not valid."
  end

  def logout
    "Logged out Successfully!"
  end

  def welcome_shop_owner
    "Welcome back, #{current_shop_owner.first_name}"
  end

  def welcome_user
    "Welcome back, #{current_user.first_name}"
  end
end
