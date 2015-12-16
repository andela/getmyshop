class Specification < ActiveRecord::Base
  belongs_to :product

  validates :key, length: { minimum: 2, maximum: 40 }
  validates :value, length: { minimum: 2 }
end
