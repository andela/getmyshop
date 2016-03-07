FactoryGirl.define do
  factory :regular_user do
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    email { Faker::Internet.email }
    password { Faker::Internet.password }
    reset_code { Faker::Lorem.characters }
  end
end
