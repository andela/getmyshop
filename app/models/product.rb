class Product < ActiveRecord::Base
  has_many :product_image_links
  belongs_to :category
  before_save :generate_code

  validates :name, length: { maximum: 60 }, presence: true
  validates :price, presence: true, numericality: {
    only_integer: true,
    greater_than: 0
  }
  validates :description, presence: true
  validates :quantity, presence: true

  def generate_code
    generator = [*("A".."Z"), *("0".."9")].sample(8).join
    if Product.find_by_code(generator)
      generate_code
    else
      self.code = generator
    end
  end
end
