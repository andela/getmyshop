require "rails_helper"

RSpec.describe "Category Page Test", type: :feature do
  include_examples "features create shop"

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
      expect(page.body).to include product.name
    end

    scenario "navigates user to category page when clicked in the footer" do
      within("div.footer.valign-wrapper") do
        click_link(product.category.name)
      end
      sleep 2
      expect(page.body).to include(product.name)
    end
  end

  feature "Filtering Widget" do
    scenario "filtering by low price" do
      visit category_path(product)
      fill_in("lower-value", with: 900)
      expect(page.body).to have_content(product.name)
    end

    scenario "filtering by high price" do
      product_two = Product.last
      visit category_path(product_two)
      fill_in("lower-value", with: 1000)
      fill_in("upper-value", with: 5000)
      expect(page.body).to have_content(product_two.name)
    end

    scenario "filtering by subcategories" do
      visit category_path(product)
      select product.subcategory.name, from: "filterrific_with_subcategory"
      expect(page).to have_css("#filterrific_results", visible: true)
      expect(page).to have_content(product.name)
    end

    scenario "filtering by categories" do
      visit category_path(product)
      select product.category.name, from: "filterrific_with_category"
      expect(page).to have_css("#filterrific_results", visible: true)
      expect(page).to have_content(product.name)
    end
  end
end
