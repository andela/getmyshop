FactoryGirl.define do
  factory :user do
    factory :regular_user, class: RegularUser do
      first_name { Faker::Name.first_name }
      last_name { Faker::Name.last_name }
      email { Faker::Internet.email }
      password { Faker::Internet.password }
    end
  end
end
