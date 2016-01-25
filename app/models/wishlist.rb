class Wishlist < ActiveRecord::Base
  belongs_to :product
  scope(
    :user_products,
    lambda do |user_id|
      where(user_id: user_id).select("id", "product_id", "created_at")
    end
  )

  def exists?
    Wishlist.exists?(user_id: user_id, product_id: product_id)
  end
end
