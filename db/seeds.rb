Category.destroy_all
Product.destroy_all
ProductImageLink.destroy_all

categories = %w(Fashion Electronics Home\ and\ Kitchen Baby,\ Kids\ and\ Toys)
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

  4.times do
    new_product = Product.new
    new_product.name = Faker::Commerce.product_name
    new_product.price = Faker::Number.number(2 + rand(3))
    new_product.quantity = Faker::Number.number(2)
    new_product.description = Faker::Hipster.paragraph(10)
    new_product.category_id = new_category.id
    new_product.save

    new_product_image_link = ProductImageLink.new
    new_product_image_link.link_name = image_links[rand(image_links.length)]
    new_product_image_link.product_id = new_product.id
    new_product_image_link.save
  end
end
