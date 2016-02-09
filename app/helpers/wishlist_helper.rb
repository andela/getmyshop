module WishlistHelper
  def wishlist_display
    if @wishproducts.empty?
      render partial: "empty_wishlist"
    else
      render partial: "wishlist_heading"
    end
  end
end
