FactoryGirl.define do
  factory :order do
    order_number Faker::Number.number(10).to_s
    payment_method ["pay-on-delivery", "paypal", "getmyshop-pay"].sample
    total_amount Faker::Commerce.price
    user nil
    address nil
  end
end
