require "rails_helper"

RSpec.describe Category, type: :model do
  context "When initializing a category" do
    it "is successful when all arguments are correct" do
      category = create(:category)
      expect(category).to be_valid
    end

    it "returns correct menu categories" do
      expect(Category.menu_categories.first.name).to eql(
        Category.first.name)
    end

    it "can return related products" do
      2.times do
        create(:subcategory) do |subcategory|
          create_list(:product, 2, subcategory: subcategory)
        end
      end
      product = Product.last
      expect(product.category.related_products(product.id).count).to eql 1
    end
  end
end
