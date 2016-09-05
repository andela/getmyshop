require "rails_helper"

RSpec.describe "Viewing Orders History", type: :feature do
  before(:each) do
    @shop_owner = create :shop_owner
    @shop_owner.update(verified: true)
    shop_owner_signin_helper(@shop_owner.email, "password")
  end

  context "when orders are present" do
    let!(:orders) do
      create_list(:order, 30, status: "Pending", shop: @shop_owner.shop)
    end

    it "renders all orders information in table rows" do
      visit admin_shop_orders_path

      expect(page).to have_selector("table tr", count: 16)
      expect(page).to have_content orders.first.order_number
    end
  end

  context "when orders are not present" do
    it "renders no order information" do
      visit admin_shop_orders_path

      expect(page).to_not have_selector("table td")
    end
  end
end
