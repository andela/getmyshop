class Subcategory < ActiveRecord::Base
  has_many :products
  belongs_to :category

  validates :name, presence: true

  scope :unique, -> { group(:name) }
  scope :by_category, ->(category) { where("category_id = ?", category) }
end
