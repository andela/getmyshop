Wishlist.destroy_all
Review.destroy_all
ProductImageLink.destroy_all
Specification.destroy_all
Product.destroy_all
Subcategory.destroy_all
Category.destroy_all

categories = %w(
  Fashion
  Electronics
  Home\ and\ Kitchen
  Baby,\ Kids\ and\ Toys
  Machinery
  Books
  Sports\ and\ Fitness
)
image_links = %w(
  http://i.imgur.com/QsgYAlQ.png
  http://i.imgur.com/JQOY8u9.jpg
  http://i.imgur.com/Pqlmpic.jpg
  http://i.imgur.com/QsgYAlQ.png
  http://i.imgur.com/6VuVwkr.jpg
  http://i.imgur.com/kh6zWa5.jpg
  http://i.imgur.com/ToxiFz1.png
  http://i.imgur.com/YYnFLrm.png
  http://i.imgur.com/16vrQzW.jpg
  http://i.imgur.com/hBjUwMG.jpg
  http://i.imgur.com/iIh0TUB.jpg
  http://i.imgur.com/16vrQzW.jpg
)

categories.each do |category|
  new_category = Category.create(name: category)

  70.times do
    new_product = Product.new
    new_product.name = Faker::Commerce.product_name
    new_product.price = Faker::Number.number(2 + rand(3))
    new_product.quantity = Faker::Number.number(2)
    new_product.brand = Faker::Company.name
    new_product.description = Faker::Hipster.paragraph(10)

    new_subcategory = Subcategory.new
    new_subcategory.name = Faker::Commerce.department(1)
    new_subcategory.category_id = new_category.id
    new_subcategory.save
    new_product.subcategory_id = new_subcategory.id

    new_product.size = Faker::Lorem.words(4).join(",")
    new_product.save

    new_product_image_link = ProductImageLink.new
    new_product_image_link.link_name = image_links[rand(image_links.length)]
    new_product_image_link.product_id = new_product.id
    new_product_image_link.save

    2.times do
      new_user = User.new
      new_user.first_name = Faker::Name.first_name
      new_user.last_name = Faker::Name.last_name
      new_user.email = Faker::Internet.email
      new_user.save

      new_review = Review.new
      new_review.product_id = new_product.id
      new_review.user_id = new_user.id
      new_review.rating = Faker::Number.between(1, 5)
      new_review.comment = Faker::Hipster.paragraph(3)
      new_review.save
    end

    5.times do
      new_specification = Specification.new

      new_specification.key = Faker::Lorem.word
      new_specification.value = Faker::Hipster.sentence
      new_specification.product_id = new_product.id
      new_specification.save
    end
  end
end
