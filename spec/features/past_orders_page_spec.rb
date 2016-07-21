require "rails_helper"

RSpec.describe "Ordering page", type: :feature, js: true do
  after(:all) { DatabaseCleaner.clean_with(:truncation) }

  before(:all) do
    @user = create :regular_user
    @user.update(verified: true)
  end
  let(:order) { create :order }
  let(:address) { build :address }

  context "when order is made" do
    it "shows order details" do
      signin_helper(@user.email, @user.password)
      order.update_attributes(user: @user, address: address)
      visit past_orders_path
      expect(page).to have_content "Details"
    end
  end

  context "when no order is made" do
    it "should sign user in" do
      signin_helper(@user.email, @user.password)
      visit past_orders_path
      expect(page).to have_content "You currently have no Orders"
    end
  end

  describe "#order_page" do
    context "when no orders" do
      it "inform user of having no orders" do
        signin_helper(@user.email, @user.password)
        visit past_orders_path
        expect(page).to have_content "You currently have no Orders"
      end
    end

    context "when there is at least an order" do
      it "inform user of having no orders" do
        signin_helper(@user.email, @user.password)
        order.update_attributes(user: @user, address: address)
        visit past_orders_path
        expect(page).to have_content "Order Number"
      end
    end
  end

  describe "order tracking" do
    before(:each) { order.user.update(verified: true) }

    context "when an order is made" do
      it "should have an order status of pending" do
        signin_helper(order.user.email, "password")
        visit past_orders_path
        expect(page).to have_content("Pending")
      end
    end

    context "user can cancel order if status not delivered" do
      it "user can cancel order" do
        signin_helper(order.user.email, "password")
        visit past_orders_path
        click_link("details")
        click_link("Cancel Order")
        expect(page).to have_content("Order cancelled")
      end
    end
  end
end
