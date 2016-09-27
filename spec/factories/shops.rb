FactoryGirl.define do
  name = Faker::Company.name
  factory :shop do
    name name
    url name.downcase.gsub /[\s,-]/, ""
    description Faker::Company.catch_phrase
    address Faker::Address.street_address
    city Faker::Address.city
    state Faker::Address.state
    country Faker::Address.country
    phone Faker::PhoneNumber.phone_number

    transient do
      product_count 0
    end

    after(:create) do |shop, evaluator|
      FactoryGirl.create_list(:product, evaluator.product_count, shop: shop)
    end
  end
end
