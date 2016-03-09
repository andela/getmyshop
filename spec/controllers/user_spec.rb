require "rails_helper"

RSpec.describe UsersController do
  before(:each) do
    User.destroy_all
  end
  it "renders the right view when user clicks on forgot_password" do
    get :forgot
    expect(response).to render_template "forgot_password"
  end

  context "While trying to submit invalid email" do
    it "raises the right error when email is not valid" do
      user = create(:regular_user)
      post :process_email, email: user.email + "invalid"
      expect(flash["error"]).to include "No user found with this email"
      expect(response).to redirect_to(forgot_users_path)
      user.destroy
    end
  end
  context "While trying to submit a valid email" do
    it "message is displayed and mail is sent if valid email was supplied" do
      user = create(:regular_user)
      post :process_email, email: user.email
      expect(flash["success"]).to include "An Email"\
      " has been sent with instructions to change your password"
      expect(response).to redirect_to(forgot_users_path)
      user.destroy
    end
  end

  context "When changing password" do
    it "changes the user password if he has the right reset_code" do
      user = create(:regular_user)
      post :reset, id: user.id, reset_code: user.reset_code, password: "adebayo"
      user = RegularUser.find_by_id(user.id)
      expect(user.authenticate("adebayo")).to be_truthy
    end

    it "resets reset_code column to nil for user after changing password" do
      user = create(:regular_user)
      post :reset, id: user.id, reset_code: user.reset_code,
                   password: "adebayo"
      user = RegularUser.find_by_id(user.id)
      expect(user.reset_code).to be nil
    end
    it "redirects forgot password and displays error if resetcode is invalid" do
      user = create(:regular_user)
      post :reset, id: user.id, reset_code: "kkk", password: "adebayo"
      expect(flash["notice"]).to include "some error occured"
      expect(response).to render_template "forgot_password"
    end
  end
end
