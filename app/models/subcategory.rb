class Subcategory < ActiveRecord::Base
  has_many :products
  belongs_to :category

  validates :name, presence: true
end
