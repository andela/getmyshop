require "rails_helper"

RSpec.describe "Category Page Test", type: :feature do
  before(:all) do
    create(:product, price: 1000)
    create(:product, price: 5000)
  end

  let(:product) { Product.first }
  context "returns the Category selected", js: true do
    it "returns the correct element", :correct_element do
      visit category_path(product)
      expect(page).to have_css(".category-span", visible: true)
      page.find(".category-span").hover
      expect(page).to have_css('#category-dropdown', visible: true)
      first(:link, product.category.name).click
      expect(page).to have_content(product.name)
    end
  end

  describe "Filtering Widget" do
    context "filtering by low price" do
      it "can filter by price" do
        visit "categories"
        fill_in("lower-value", with: 900)
        expect(page).to have_content(product.name)
      end
    end

    context "filtering by high price" do
      it "can filter by high price" do
        product_two = Product.last
        visit "categories"
        fill_in("lower-value", with: 1000)
        fill_in("upper-value", with: 5000)
        expect(page).to have_content(product_two.name)
      end
    end

    context "filtering by subcategories" do
      it "can filter by Subcategory" do
        visit "categories"
        select product.subcategory.name, from: "filterrific_with_subcategory"
        expect(page).to have_css("#filterrific_results", visible: true)
        expect(page).to have_content(product.name)
      end
    end

    context "filtering by categories" do
      it "can filter by category" do
        visit "categories"
        select product.category.name, from: "filterrific_with_category"
        expect(page).to have_css("#filterrific_results", visible: true)
        expect(page).to have_content(product.name)
      end
    end
  end
end
