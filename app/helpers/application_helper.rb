module ApplicationHelper
  def auth_link
    if logged_in
      render "user_profile"
    else
      link_to "SIGN IN", login_path, class: "white-text"
    end
  end
end
