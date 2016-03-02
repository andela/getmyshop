require "rails_helper"

RSpec.describe "Signup process", type: :feature do
  context "when done with correct inputs" do
    let(:user) { build :regular_user }

    it "should sign user up" do
      signup_helper(
        user.first_name,
        user.last_name,
        user.email,
        user.password
      )

      expect(page).to have_content "Welcome, #{user.first_name}"
    end
  end

  context "when at least an input is wrong" do
    let(:user) { build :regular_user }

    it "should sign user up" do
      signup_helper(
        user.first_name,
        nil,
        user.email,
        user.password
      )

      expect(page).to have_no_content "Welcome, #{user.first_name}"
    end
  end

  context "when user intends to signin" do
    it "should link signin page" do
      visit new_user_path
      click_link "Sign In"

      expect(page).to have_content "Forgot your password?"
    end
  end
end
