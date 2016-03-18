require "rails_helper"

RSpec.describe UsersController do
  before(:all) do
    create(:regular_user)
  end

  after(:all) { DatabaseCleaner.clean_with(:truncation) }

  let(:user) { RegularUser.first }

  describe "GET activate" do
    it "turns the user's active_status to true" do
      get :activate, user_id: user.id, activation_token: user.activation_token

      user.reload
      expect(user.active_status).to be_truthy
      expect(session[:user_id]).to eq user.id
      expect(response).to redirect_to root_path
    end
  end

  describe "GET forgot" do
    it "renders the right view when user clicks on forgot_password" do
      get :forgot
      expect(response).to render_template "forgot_password"
    end
  end

  describe "POST :process_email" do
    context "While trying to submit invalid email" do
      it "raises the right error when email is not valid" do
        post :process_email, email: user.email + "invalid"
        expect(flash["error"]).to include "No user found with this email"
        expect(response).to redirect_to(forgot_users_path)
      end
    end

    context "While trying to submit a valid email" do
      it "message is displayed and mail is sent if valid email was supplied" do
        post :process_email, email: user.email
        expect(flash["success"]).to include "An Email"\
        " has been sent with instructions to change your password"
        expect(response).to redirect_to(forgot_users_path)
      end
    end
  end

  describe "POST :reset" do
    context "When changing password" do
      before(:all) { RegularUser.first.update(reset_code: "thisisaresetcode") }
      
      it "changes the user password if he has the right reset_code" do
        post(
          :reset,
          id: user.id,
          reset_code: user.reset_code,
          password: "adebayo"
        )
        user.reload
        expect(user.authenticate("adebayo")).to be_truthy
      end

      it "resets reset_code column to nil for user after changing password" do
        post :reset, id: user.id, reset_code: user.reset_code,
        password: "adebayo"
        user.reload
        expect(user.reset_code).to be nil
      end
      it "fails and displays error if resetcode is invalid" do
        post :reset, id: user.id, reset_code: "kkk", password: "adebayo"
        expect(flash["notice"]).to include "some error occured"
        expect(response).to render_template "forgot_password"
      end
    end
  end
end
