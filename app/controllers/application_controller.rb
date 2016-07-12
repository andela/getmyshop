require_relative "../helpers/message_helper"
class ApplicationController < ActionController::Base
  include MessageHelper
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
