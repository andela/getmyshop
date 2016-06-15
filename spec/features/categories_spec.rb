require "rails_helper"

RSpec.describe "Category Page Test", type: :feature do
  before(:all) do
    create(:product, price: 1000)
    create(:product, price: 5000)
  end

  let(:product) { Product.first }

  context "returns the correct category", js: true do
    it "when the category name is clicked on category dropdown" do
      visit category_path(product)
      page.find(".category-span").hover
      within(".category-span") do
        click_link(product.category.name)
      end
      expect(page).to have_content(product.name)
    end

    it "when category name is clicked on footer quicklinks" do
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
<<<<<<< 97a0c18648de6650c97fa4a1682d0072265b6388
<<<<<<< 175b69b29aa1c1ef1c29cc95c75418018a7f99f7
end
=======
end
>>>>>>> test(category_links): Add footer quicklinks test
=======
end
>>>>>>> fix(test): Resolve circle ci test issues
