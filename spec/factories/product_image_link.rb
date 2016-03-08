FactoryGirl.define do
  factory :product_image_link do
    link_name Faker::Placeholdit.image
    product factory: :product
  end
end
