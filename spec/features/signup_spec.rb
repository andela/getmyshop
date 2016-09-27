require "rails_helper"

RSpec.describe "Signup process", type: :feature do
  include_examples "features create shop"

  let(:user) { build :regular_user }

  feature "when done with correct inputs" do
    scenario "should sign user up" do
      signup_helper(
        user.first_name,
        user.last_name,
        user.email,
        user.password
      )

      visit shop_path(shop.url)
      expect(page).to have_content "Welcome, #{user.first_name}"
    end
  end

  feature "when at least an input is wrong" do
    scenario "should sign user up" do
      signup_helper(
        user.first_name,
        nil,
        user.email,
        user.password
      )

      expect(page).to have_no_content "Welcome, #{user.first_name}"
    end
  end

  feature "when user intends to signin" do
    scenario "should link signin page" do
      visit new_user_path
      click_link "Sign In"

      expect(page).to have_content "Forgot your password?"
    end
  end
end
