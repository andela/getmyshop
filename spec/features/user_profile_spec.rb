require "rails_helper"
require "support/address_helpers"
require "support/checkout_helpers"

include AddressHelpers
include CheckoutHelpers

RSpec.describe "User profile", type: :feature do
  include_examples "features create shop"
  before(:all) do
    @user = User.create(
      email: Faker::Internet.email,
      first_name: Faker::Name.name,
      last_name: Faker::Name.name,
      password_digest: Faker::Internet.password
    )
  end

  describe "when on the profile page" do
    before(:each) do
      allow_any_instance_of(ApplicationController).
        to receive(:current_user) { @user }
      visit account_users_path
    end

    feature "on the profile page" do
      scenario "displays user information", js: true do
        expect(page).to have_content @user.first_name
        expect(page).to have_content @user.last_name
        expect(page).to have_content @user.email
      end
    end

    feature "updating user information" do
      scenario "updates user details", js: true do
        expect(page).to have_content @user.first_name
        find(".my-icon").click
        expect(page).to have_content "EDIT PROFILE"
        new_email = Faker::Internet.email
        fill_in "Email", with: new_email
        click_on("Update")
        expect(User.last.email).to eq new_email
      end
    end

    feature "viewing addresses" do
      scenario "displays user addresses" do
        address = create(:address, user: @user)
        find("#manage-address").click
        expect(page).to have_content address.address
      end
    end

    feature "viewing Past Orders" do
      scenario "displays user past orders" do
        find(".past-orders").click
        expect(current_path).to eql past_orders_path
      end
    end

    feature "viewing wishlist" do
      scenario "redirects to wishlist page" do
        find("#wishlist").click
        # expect(current_path).to eql wishlist_index_path
      end
    end

    feature "Deleting user account" do
      scenario "deletes a user account", js: true do
        find("#delete").click
        page.driver.browser.switch_to.alert.accept
        expect(current_path).to eql root_path
        # expect(page).to have_content "Account Deactivated"
        expect(User.last.active).to be false
      end
    end
  end
end
