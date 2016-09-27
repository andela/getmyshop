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
      page.execute_script("$('#delete_product').click()")
      click_on("Continue")

      expect(page).to have_content("You currently have no products")
    end
  end
end
