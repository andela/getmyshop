require "rails_helper"

RSpec.describe "Making a review", type: :feature do
  context "When a user has bought a product" do
    let(:user) { create :regular_user }
    let(:order) { create :order }
    let(:address) { build :address }
    let(:product) { create :product }
    let(:order_item) { create :order_item }

    after(:all) { DatabaseCleaner.clean_with(:truncation) }

    it "Adds review to a product if user has bought the product", js: true do
      order.update_attributes(user: user, address: address)
      order_item.update_attributes(order: order, product: product)

      signin_helper(user.email, user.password)
      visit past_orders_path
      expect(page).to have_content "Details"

      click_link "details"
      click_link("Review")
      fill_in("title", with: "Nice product")
      fill_in("comment", with: "Love the sleek design")
      find("#star3").click
      click_button("Submit")

      expect(product.reviews.last.title).to eq "Nice product"
      expect(product.reviews.last.rating).to eq 3
    end
  end
end
