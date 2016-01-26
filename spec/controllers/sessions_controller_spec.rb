require "rails_helper"

RSpec.describe SessionsController do
  it "renders the right view when user attempts to sign in" do
    get :new
    expect(response).to render_template "new"
  end

  context "while authenticating with invalid details" do
    it "raises the right error when email is not valid" do
      user = create(:regular_user)
      post :create, session: {
        email: ("invalid" + user.email), password: user.password
      }
      expect(flash["errors"]).to include "Email or Password not valid."
      expect(response).to redirect_to login_path
      user.destroy
    end

    it "raises the right error when password is not valid" do
      user = create(:regular_user)
      post :create, session: {
        email: user.email, password: ("invalid" + user.password)
      }
      expect(flash["errors"]).to include "Email or Password not valid."
      expect(response).to redirect_to login_path
      user.destroy
    end
  end

  context "while authenticating with valid details" do
    it "logs the user in successfully" do
      user = create(:regular_user)
      post :create, session: {
        email: user.email, password: user.password
      }
      expect(session[:user_id]).to eql user.id
      expect(response).to redirect_to root_path
      user.destroy
    end
  end
end
