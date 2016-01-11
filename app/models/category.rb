class Category < ActiveRecord::Base
  has_many :subcategories
  has_many :products, through: :subcategory
  validates :name, presence: true
end
