module MessageService
  def self.account_activated
    "Account activated successfully."
  end

  def self.activation_failed
    "Unable to activate account. "\
    "If you copied the link, make sure you copied it correctly."
  end

  def self.welcome
    "Welcome To GetMyShop"
  end

  def self.account_created
    "An activation link has been sent to your email, click on it to "\
    "activate account"
  end

  def self.shop_created
    "Shop creation successful"
  end

  def self.product_created
    "Product has been created"
  end

  def self.login_failure
    "Email or Password not valid."
  end

  def self.logout
    "Logged out Successfully!"
  end

  def self.change_password
    "An Email has been sent with instructions to change your password."
  end

  def self.password_changed
    "Password Successfully Changed. Sign in with new password"
  end

  def self.password_reset
    "Reset Your Password"
  end

  def self.user_not_found
    "No user found with this email"
  end

  def self.error_occured
    "some error occured"
  end

  def self.account_updated
    "Account Updated"
  end

  def self.account_deactivated
    "Account Deactivated"
  end
end
