class ProductImageLink < ActiveRecord::Base
  belongs_to :product
  validates :link_name, presence: true
end
