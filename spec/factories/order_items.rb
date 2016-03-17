FactoryGirl.define do
  factory :order_item do
    quantity Faker::Number.between(1, 5)
    order factory: :order
    product factory: :product
  end
end
