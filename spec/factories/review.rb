FactoryGirl.define do
  factory :review do
    comment { Faker::Hacker.say_something_smart }
    rating { (1..5).to_a.sample }
    product factory: :product
    user factory: :regular_user
  end
end
