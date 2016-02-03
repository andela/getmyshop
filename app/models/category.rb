class Category < ActiveRecord::Base
  has_many :subcategories
  has_many :products, through: :subcategories
  validates :name, presence: true

  def related_products(product_id)
    products.where.not(id: product_id).order("RANDOM()").limit(3)
  end
end
