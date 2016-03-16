FactoryGirl.define do
  factory :wishlist do
    user factory: :regular_user
    product factory: :product
  end
end
