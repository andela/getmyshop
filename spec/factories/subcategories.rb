FactoryGirl.define do
  factory :subcategory do
    name { Faker::Commerce.product_name }
    category factory: :category
  end
end
