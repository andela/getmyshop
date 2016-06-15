require "rails_helper"

RSpec.describe "Category Page Test", type: :feature do
  before(:all) do
    create(:product, price: 1000)
    create(:product, price: 5000)
  end

  let(:product) { Product.first }

  feature "Category links", js: true do
    scenario "navigates user to category page when clicked in the header" do
      visit category_path(product)
      page.find(".category-span").hover
      within(".category-span") do
        click_link(product.category.name)
      end
      expect(page).to have_content(product.name)
    end

    scenario "navigates user to category page when clicked in the footer" do
      visit root_path
      within("div.footer.valign-wrapper") do
        click_link(product.category.name)
      end

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