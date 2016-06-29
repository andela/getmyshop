require "rails_helper"

RSpec.describe "Signin process", type: :feature do
  before(:all) { create(:regular_user, password: "password") }
  after(:all) { DatabaseCleaner.clean_with(:truncation) }
  let(:user) { User.last }

  context "when done with correct inputs" do
    it "should sign user in" do
      signin_helper(user.email, "password")

      expect(page).to have_content "Welcome"
    end
  end

  context "when done with correct inputs for shop owner" do
    it "should sign shop owner in" do
      shop_signin_helper(user.email, "password")

      expect(page).to have_content "Welcome"
    end
  end

  context "when inputs are incorrect" do
    it "would not sign user in" do
      signin_helper(user.email, "wrong_password")

      expect(page).to have_no_content "SIGN OUT"
    end
  end
end
