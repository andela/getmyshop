require "rails_helper"

RSpec.describe "Shop Owner Signin process", type: :feature do
  before(:all) do
    @shop_owner = create :shop_owner
    @shop_owner.update(verified: true)
  end

  feature "when user enters correct inputs" do
    scenario "signs in shop owner" do
      shop_owner_signin_helper(@shop_owner.email, "password")

      expect(page).to have_content "Dashboard"
    end
  end

  feature "when inputs are incorrect" do
    scenario "does not sign shop owner in" do
      shop_owner_signin_helper(@shop_owner.email, "wrong_password")

      expect(page).to have_no_content "SIGN OUT"
    end
  end
end
