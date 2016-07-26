FactoryGirl.define do
  factory :shop do
    name Faker::Company.name
    url Faker::Internet.url
    description Faker::Company.catch_phrase
    address Faker::Address.street_address
    city Faker::Address.city
    state Faker::Address.state
    country Faker::Address.country
    phone Faker::PhoneNumber.phone_number

    after(:create) do |shop|
      FactoryGirl.create_list(:product, 2, shop: shop)
    end
  end
end
