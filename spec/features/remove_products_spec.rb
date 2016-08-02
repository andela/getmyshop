require "rails_helper"

RSpec.describe "Removing Products", type: :feature do
  before(:all) do
    @shop_owner = create(:shop_owner, verified: true)
    create(:product, shop: @shop_owner.shop)
  end

  feature "when delete button is clicked on a product", js: true do
    scenario "removes the product" do
      shop_owner_signin_helper(@shop_owner.email, "password")

      visit dashboard_path
      page.execute_script("$('#delete_product').click()")
      sleep 3
      click_on("Continue")
      expect(page).to have_content("Deleted Succesfully!")
    end
  end
end
