require "rails_helper"

RSpec.describe Category, type: :model do
  context "When initializing a category" do
    it "is successful when all arguments are correct" do
      category = create(:category_with_products)
      expect(category).to be_valid
    end

    it "returns correct menu categories" do
      create_list(:category_with_products, 2)
      expect(Category.menu_categories.first.name).to eql(
        Category.first.name
      )
    end

    it "can return related products" do
      create_list(:subcategory_with_products, 2)

      product = Product.last
      expect(product.category.related_products(product.id).count).to eql 2
    end
  end
end
