class ApplicationController < ActionController::Base
  include ApplicationHelper
  protect_from_forgery with: :exception

  helper_method :current_user, :logged_in, :current_shop_owner
  before_action :set_categories_menu
  before_action :get_shop

  def set_categories_menu
    @menu_categories = Category.menu_categories
  end

  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  def current_shop_owner
    @current_shop_owner ||= ShopOwner.find_by(id: session[:admin_id])
  end

  def get_shop
    @categories = Category.all.limit(3)
    @shop = Shop.find_by url: (params[:url] || session[:shop_url])
    @products = (@shop.products if @shop) || []
    session[:shop_url] = @shop.url
    @shop.color = (@shop.color if @shop) || 'teal'
  end

  def logged_in
    current_user.present?
  end

  def shop_owner_logged_in
    current_shop_owner.present?
  end
end
