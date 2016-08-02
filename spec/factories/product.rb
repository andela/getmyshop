FactoryGirl.define do
  factory :product do
    name { Faker::Commerce.product_name }
    price { Faker::Number.number(2 + rand(3)) }
    description { Faker::Hipster.paragraph(3, true) }
    quantity Faker::Number.number(2)
    brand { Faker::Company.name }
    subcategory factory: :subcategory

    transient do
      image_link_count 2
      review_count 2
      shop nil
    end

    after(:create) do |product, evaluator|
      create_list(
        :product_image_link,
        evaluator.image_link_count,
        product: product
      )
      create_list(:review, evaluator.review_count, product: product)
      product.update(shop: evaluator.shop)
    end
  end
end
