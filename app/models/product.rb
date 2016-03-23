class Product < ActiveRecord::Base
  filterrific(
    available_filters: [
      :with_size,
      :with_low_price,
      :with_high_price,
      :with_category,
      :with_brand,
    ]
  )

  has_many :product_image_links
  has_many :specifications
  has_many :order_items
  has_many :reviews
  belongs_to :subcategory
  has_one :category, through: :subcategory

  before_create :generate_code

  validates :name, length: { maximum: 60 }, presence: true
  validates :price, presence: true, numericality: {
    only_integer: true,
    greater_than: 0
  }
  validates :description, presence: true
  validates :quantity, presence: true
  validates :brand, presence: true

  scope :with_low_price, lambda { |low_price|
    where("price >= ?", low_price)
  }
  scope :with_high_price, lambda { |high_price|
    where("price < ?", high_price)
    # byebug
  }
  scope :with_size, lambda { |size|
    where(size: [*size])
  }
  # With category is actually filtering by the product's subcategory
  scope :with_category, lambda { |subcategory|
    Product.includes(:subcategory).joins(:subcategory).where(
      "subcategories.name  = ?", subcategory
    )
  }

  # With brand is actually filtering by the product's category
  scope :with_brand, lambda { |category|
    Product.includes(:category).joins(:category).where(
      "categories.name = ?", category
    )
  }
  def self.search(term)
    where("lower(name) like ? or brand like ?", "%#{term}%", "%#{term}%")
  end

  def generate_code
    generator = [*("A".."Z"), *("0".."9")].sample(8).join
    if Product.find_by_code(generator)
      generate_code
    else
      self.code = generator
    end
  end

  def size_values
    size.split(",").map(&:strip)
  end
end
