class WishlistController < ApplicationController
  def index
    return direct_to_login_page unless logged_in
    @wishproducts = Wishlist.user_products(current_user.id)
  end

  def update
    if logged_in
      treat_wishlist_request
    else
      redirect_to login_path
    end
  end

  private

  def treat_wishlist_request
    case params[:edit_action]
    when "add"
      render plain: save_to_wishlist
    when "delete"
      render plain: delete_from_wishlist
    end
  end

  def save_to_wishlist
    wish_product = Wishlist.new(wishlist_params)

    if wish_product.exists?
      "Product already exists in Wishlist"
    else
      wish_product.save
      "Product added Successfully"
    end
  end

  def wishlist_params
    {
      user_id: current_user.id,
      product_id: params[:product_id]
    }
  end

  def delete_from_wishlist
    Wishlist.delete(params[:wishlist_id])

    "Product removed Successfully"
  end

  def direct_to_login_page
    flash[:errors] = (flash[:errors] || []) << "Login required."
    redirect_to login_path
  end
end
