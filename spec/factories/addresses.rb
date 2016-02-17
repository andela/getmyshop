FactoryGirl.define do
  factory :address do
    name Faker::Name.name
    email Faker::Internet.email
    address Faker::Address.street_address
    landmark ""
    gender "male"
    phone Faker::PhoneNumber.phone_number
    state Faker::Address.state
    city Faker::Address.city
    country Faker::Address.country
  end
end
