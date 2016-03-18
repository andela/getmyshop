FactoryGirl.define do
  factory :address do
    name Faker::Name.name
    email Faker::Internet.email
    address Faker::Address.street_address
    gender %w(male, female).sample
    phone Faker::PhoneNumber.subscriber_number(11)
    state Faker::Address.state
    city Faker::Address.city
    country Faker::Address.country

    user factory: :regular_user

    factory :address_with_orders do
      transient do
        order_count 2
      end

      after(:create) do |address, evaluator|
        create_list(
          :order_with_items,
          evaluator.order_count,
          address: address,
          user: evaluator.user
        )
      end
    end
  end
end
