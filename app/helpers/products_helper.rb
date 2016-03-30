module ProductsHelper
  def wishlist_add_link
    if logged_in && wishlist_present
      render partial: "added_to_wishlist"
    elsif logged_in
      render partial: "add_to_wishlist"
    else
      render partial: "redirect_wishlist_to_login"
    end
  end

  def wishlist_present
    Wishlist.exists?(product_id: @product.id, user_id: current_user.id)
  end

  def get_rating(product)
    total = product.reviews.inject(0) { |sum, review| sum + review.rating }
    total / product.reviews.count
  end
end
