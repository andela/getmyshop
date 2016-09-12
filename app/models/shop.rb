class Shop < ActiveRecord::Base
  belongs_to :shop_owner
  has_many :products, dependent: :destroy
  has_many :orders
  accepts_nested_attributes_for :orders

  validates :name, presence: true, uniqueness: true
  validates :url, presence: true, uniqueness: true
  validates :phone, presence: true
end
