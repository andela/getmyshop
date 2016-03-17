FactoryGirl.define do
  factory :subcategory do
    name { Faker::Commerce.product_name }
    category factory: :category

    factory :subcategory_with_products do
      transient do
        product_count 3
      end

      after(:create) do |subcategory, evaluator|
        create_list(
          :product,
          evaluator.product_count,
          subcategory: subcategory
        )
      end
    end
  end
end
