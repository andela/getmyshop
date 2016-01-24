module ApplicationHelper
  def auth_link
    if logged_in
      link_to "SIGN OUT", logout_path, class: "black-text"
    else
      link_to "SIGN IN", login_path, class: "black-text"
    end
  end
end
