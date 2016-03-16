require "rails_helper"
require "support/address_helpers"
require "support/checkout_helpers"

include AddressHelpers
include CheckoutHelpers

RSpec.describe "Checkout Feature", type: :feature do
  before(:all) do
    @products = []
    5.times { @products << assemble_product }

    @user = create(:regular_user)
  end

  before(:each) do
    allow_any_instance_of(ApplicationController).
      to receive(:current_user).and_return(@user)
  end

  it "adds products successfully", js: true do
    add_products_and_checkout
    fill_in_address
    click_button "Save and Continue"
    click_button "Proceed to Payment"
    click_button "Complete Order"
    expect(page).to have_content("Thank you!")
  end
end
