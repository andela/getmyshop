require "rails_helper"
require "support/address_helpers"
require "support/checkout_helpers"

include AddressHelpers
include CheckoutHelpers

RSpec.describe "User profile", type: :feature do
  before(:all) do
    @user = User.create(
      email: Faker::Internet.email,
      first_name: Faker::Name.name,
      last_name: Faker::Name.name,
      password_digest: Faker::Internet.password
    )
  end
  after(:all) { DatabaseCleaner.clean_with(:truncation) }

  describe "when on the profile page" do
    before(:each) do
      allow_any_instance_of(ApplicationController).
        to receive(:current_user) { @user }
      visit account_users_path
    end

    context "on the profile page" do
      it "displays user information", js: true do
        expect(page).to have_content @user.first_name
        expect(page).to have_content @user.last_name
        expect(page).to have_content @user.email
      end
    end

    context "updating user information" do
      it "updates user details", js: true do
        expect(page).to have_content @user.first_name
        find(".my-icon").click
        expect(page).to have_content "EDIT PROFILE"
        new_email = Faker::Internet.email
        fill_in "Email", with: new_email
        click_on("Update")
        expect(User.last.email).to eq new_email
      end
    end

    context "viewing addresses" do
      it "displays user addresses" do
        address = create(:address, user: @user)
        find("#manage-address").click
        expect(page).to have_content address.address
      end
    end

    context "viewing Past Orders" do
      it "displays user past orders" do
        find(".past-orders").click
        expect(current_path).to eql past_orders_path
      end
    end

    context "viewing wishlist" do
      it "redirects to wishlist page" do
        find("#wishlist").click
        expect(current_path).to eql wishlist_index_path
      end
    end

    context "Deleting user account" do
      it "deletes a user account", js: true do
        find("#delete").click
        page.driver.browser.switch_to.alert.accept
        expect(current_path).to eql root_path
        expect(page).to have_content "Account Deactivated"
      end
    end
  end
end
