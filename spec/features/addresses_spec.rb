require "rails_helper"
require "support/checkout_helpers"
require "support/address_helpers"

include CheckoutHelpers
include AddressHelpers

RSpec.feature "Addresses CRUD", type: :feature, js: true do
  before(:all) do
    create(:product)
    @user = create(:user)
    @address = create(:address, user: @user)
  end

  before(:each) do
    allow_any_instance_of(ApplicationController).
      to receive(:current_user).and_return(@user)
  end

  describe "updating an address" do
    it "should update and use address" do
      visit addresses_users_path @user.id
      find(".edit-address-icon").click
      expect(page).to have_content "Fill in the delivery information"
      fill_in_address
      click_button "Save and Continue"
      expect(current_url).to include(addresses_users_path @user.id)
      expect(page.body.include? @address.name).to be_truthy
      expect(page.body.include? @address.address).to be_truthy
    end
  end

  describe "deleting an address" do
    it "should archive the address" do
      visit addresses_users_path @user.id
      find(".delete-address-icon").click
      page.driver.browser.switch_to.alert.accept
      expect(page).to have_content("Address deleted")
    end
  end
end
