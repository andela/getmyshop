FactoryGirl.define do
  factory :shop_owner do
    first_name Faker::Name.name
    last_name Faker::Name.name
    phone Faker::PhoneNumber.phone_number
    email Faker::Internet.email
    password "password"
    verified true
    reset_code "MyString"
    active true
  end
end
