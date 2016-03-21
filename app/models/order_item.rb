class OrderItem < ActiveRecord::Base
  belongs_to :order
  belongs_to :product

  validates :quantity, presence: true
end
