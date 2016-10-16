require "rails_helper"

RSpec.describe "Removing Products", type: :feature do
  include_examples "features create shop"

  before(:all) do
    create(:product)
    sleep 3
  end

  feature "when delete button is clicked on a product", js: true do
    scenario "removes the product" do
      shop_owner_signin_helper(shopowner.email, "password")
      visit shop_products_path
      find("#delete_product").click
      find("#confirm-modal").all("a").first.click

      expect(page).to have_content("You currently have no products")
    end
  end
end
