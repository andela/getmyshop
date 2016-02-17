FactoryGirl.define do
  factory :order_item do
    order nil
    product nil
    quantity Faker::Number.between(1, 5)
    size Faker::Lorem.word
  end
end
