require "rails_helper"

RSpec.describe "Landing page", type: :feature do
  feature "visiting landing page" do
    scenario "should find nav elements" do
      visit root_path

      expect(page).to have_content "Sign Up"
    end
  end
end
