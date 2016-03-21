require "rails_helper"

RSpec.describe "Category Page Test", type: :feature do
  context "returns the Category selected", js: true do
    before(:all) do
      product = create(:product)
      create(:product_image_link, product: product)
    end

    let(:product) { Product.first }

    it "returns the correct element" do
      visit product_path(product)
      expect(page).to have_css(".category-span", visible: true)
      page.find(".category-span").hover
      expect(page).to have_css('#category-dropdown', visible: true)
      click_link(product.category.name)
      expect(page).to have_content(product.name)
    end
  end
end
