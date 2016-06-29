module MessageHelper
  def welcome_user
    "Welcome back, #{current_user.first_name}"
  end

  def logout
    "Logged out Successfully!"
  end

  def invalid_login
    "Email or Password not valid."
  end
end
