require "rails_helper"

RSpec.describe "Ordering page", type: :feature, js: true do
  after(:all) { DatabaseCleaner.clean_with(:truncation) }

  context "when order is made" do
    let(:user) { create :regular_user }
    let(:order) { create :order }
    let(:address) { build :address }

    it "shows order details" do
      signin_helper(user.email, user.password)
      order.update_attributes(user: user, address: address)
      visit past_orders_path
      expect(page).to have_content "Details"
    end
  end

  context "when no order is made" do
    let(:user) { create :regular_user }
    it "should sign user in" do
      signin_helper(user.email, user.password)

      visit past_orders_path
      expect(page).to have_content "You currently have no Orders"
    end
  end

  describe "#order_page" do
    context "when no orders" do
      let(:user) { create :regular_user }
      it "inform user of having no orders" do
        signin_helper(user.email, user.password)
        visit past_orders_path
        expect(page).to have_content "You currently have no Orders"
      end
    end

    context "when there is at least an order" do
      let(:user) { create :regular_user }
      let(:order) { create :order }
      let(:address) { build :address }
      it "inform user of having no orders" do
        signin_helper(user.email, user.password)
        order.update_attributes(user: user, address: address)
        visit past_orders_path
        expect(page).to have_content "Order Number"
      end
    end
  end

  describe "order tracking" do
    let(:order) { create :order }
    context "when an order is made" do
      it "should have an order status of pending" do
        signin_helper(order.user.email, order.user.password)
        visit past_orders_path
        expect(page).to have_content("Pending")
      end
    end

    context "five hours after order is made" do
      it "should have an order status of shiped" do
        order.created_at = Time.now - 5.hour
        order.save
        signin_helper(order.user.email, order.user.password)
        visit past_orders_path
        expect(page).to have_content("Shipped")
      end
    end

    context "14 hours after order is made" do
      it "should have an order status of pending" do
        order.created_at = Time.now - 13.hour
        order.save
        signin_helper(order.user.email, order.user.password)
        visit past_orders_path
        expect(page).to have_content("Delivered")
      end
    end

    context "user can cancel order if status not delivered" do
      it "user can cancel order" do
        signin_helper(order.user.email, order.user.password)
        visit past_orders_path
        click_link("details")
        click_link("Cancel Order")
        expect(page).to have_content("Order cancelled")
      end
    end
  end
end
