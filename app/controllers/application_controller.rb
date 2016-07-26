class ApplicationController < ActionController::Base
  include ApplicationHelper
  protect_from_forgery with: :exception

  helper_method :current_user, :logged_in, :current_shop_owner
  before_action :set_categories_menu

  def set_categories_menu
    @menu_categories = Category.menu_categories
  end

  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  def current_shop_owner
    @current_shop_owner ||= ShopOwner.find_by(id: session[:user_id])
  end

  def logged_in
    current_user.present?
  end

  def shop_owner_logged_in
    current_shop_owner.present?
  end
end
