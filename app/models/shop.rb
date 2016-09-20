class Shop < ActiveRecord::Base
  belongs_to :shop_owner
  has_many :products, dependent: :destroy
  has_many :orders
  accepts_nested_attributes_for :orders

  validates :name, presence: true, uniqueness: true
  validates :url, presence: true, uniqueness: true
  validates :phone, presence: true

  def valid_orders
    Order.not_cancelled(self)
  end

  def completed_orders
    Order.completed(self)
  end

  def pending_orders
    Order.pending(self)
  end
end
