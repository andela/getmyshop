class Subcategory < ActiveRecord::Base
  has_many :products
  belongs_to :category

  validates :name, presence: true

  scope :get_unique, -> { select(:name).distinct }
  scope :by_category, ->(category) { where("category_id = ?", category) }
end
