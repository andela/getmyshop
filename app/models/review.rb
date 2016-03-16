class Review < ActiveRecord::Base
  belongs_to :product
  belongs_to :user
  validates :comment, :rating, presence: true
end
