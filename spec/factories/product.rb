FactoryGirl.define do
  factory :product do
    name { Faker::Commerce.product_name }
    price { Faker::Number.number(2 + rand(3)) }
    description { Faker::Hipster.paragraph(3, true) }
    quantity Faker::Number.number(2)
    code "AXWMWEQZ"
    brand { Faker::Company.name }
    size { Faker::StarWars.droid }
    subcategory factory: :subcategory
  end
end
