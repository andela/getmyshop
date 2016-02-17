class Review < ActiveRecord::Base
  belongs_to :product
  belongs_to :user
  validates :comment, :rating, presence: true

  def self.product_reviews(product_id)
    Review.where(product_id: product_id)
  end
end
