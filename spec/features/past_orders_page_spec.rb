require "rails_helper"

RSpec.describe "Ordering page", type: :feature, js: true do
  include_examples "features create shop"

  after(:all) { DatabaseCleaner.clean_with(:truncation) }

  before(:all) do
    @user = create :regular_user
    @user.update(verified: true)
  end
  let(:order) { create :order }
  let(:address) { build :address }

  feature "when order is made" do
    scenario "shows order details" do
      visit shop_path(shop.url)
      signin_helper(@user.email, @user.password)
      order.update_attributes(user: @user, address: address)
      visit past_orders_path
      expect(page).to have_content "Details"
    end
  end

  feature "when no order is made" do
    scenario "signs in user" do
      signin_helper(@user.email, @user.password)
      visit past_orders_path
      expect(page).to have_content "You currently have no Orders"
    end
  end

  describe "#order_page" do
    feature "when no orders in the order page" do
      scenario "informs user of having no orders" do
        signin_helper(@user.email, @user.password)
        visit past_orders_path
        expect(page).to have_content "You currently have no Orders"
      end
    end

    feature "when there is at least an order in the order page" do
      scenario "informs user of having the number of orders" do
        signin_helper(@user.email, @user.password)
        order.update_attributes(user: @user, address: address)
        visit past_orders_path
        expect(page).to have_content "Order Number"
      end
    end
  end

  describe "order tracking" do
    before(:each) { order.user.update(verified: true) }

    feature "when an order is made" do
      scenario "should have an order status of pending" do
        signin_helper(order.user.email, "password")
        visit past_orders_path
        expect(page).to have_content("Pending")
      end
    end

    feature "user can cancel order if status not delivered" do
      scenario "user can cancel order" do
        signin_helper(order.user.email, "password")
        visit past_orders_path
        click_link("details")
        click_link("Cancel Order")
        expect(page).to have_content("Order cancelled")
      end
    end
  end
end
