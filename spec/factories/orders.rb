FactoryGirl.define do
  factory :order do
    order_number Faker::Number.number(10).to_s
    payment_method ["pay-on-delivery", "paypal", "getmyshop-pay"].sample
    total_amount Faker::Commerce.price
    user factory: :regular_user
    address factory: :address
    status "Pending"

    factory :order_with_items do
      transient do
        order_item_count 4
      end

      after(:create) do |order, evaluator|
        create_list(:order_item, evaluator.order_item_count, order: order)
      end
    end
  end
end
