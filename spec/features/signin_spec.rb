require "rails_helper"

RSpec.describe "Signin process", type: :feature do
  context "when done with correct inputs" do
    let(:user) { create :regular_user }

    it "should sign user in" do
      signin_helper(user.email, user.password)

      expect(page).to have_content "SIGN OUT"
    end
  end

  context "when inputs are incorrect" do
    let(:user) { create :regular_user }

    it "would not sign user in" do
      signin_helper(user.email, "wrong_password")

      expect(page).to have_no_content "SIGN OUT"
    end
  end
end
