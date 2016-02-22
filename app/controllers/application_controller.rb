class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  helper_method :current_user, :logged_in
  before_action :set_categories_menu

  def set_categories_menu
    @menu_categories = Category.menu_categories
  end

  def current_user
    @current_user ||= User.find_by_id(session[:user_id])
  end

  def logged_in
    current_user.present?
  end
end
