require "rails_helper"
require "support/oauth_example"
RSpec.describe SessionsController do
  it "renders the right view when user attempts to sign in" do
    get :new
    expect(response).to render_template "new"
  end



  it "renders the right view when shop owner attempts to sign in" do
    get :shop_login
    expect(response).to render_template "shop_login"
  end

  context "when shop owner is attempting to sign in" do
    it "raises the right error when email is not valid" do
      user = create(:regular_user)
      post :shop_login_create, session: {
        email: "invalid #{user.email}", password: user.password
      }
      expect(flash["errors"]).to include "Email or Password not valid."
      expect(response).to redirect_to shop_login_path
      user.destroy
    end

    it "raises the right error when password is not valid" do
      user = create(:regular_user)
      post :shop_login_create, session: {
        email: user.email, password: ("invalid" + user.password)
      }
      expect(flash["errors"]).to include "Email or Password not valid."
      expect(response).to redirect_to shop_login_path
      user.destroy
    end

    it "logs the user in successfully" do
      user = create(:regular_user)
      post :shop_login_create, session: {
        email: user.email, password: user.password
      }
      expect(session[:user_id]).to eql user.id
      expect(response).to redirect_to dashboard_path
      user.destroy
    end
    
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

  context "while authenticating with Twitter Oauth" do
    it_behaves_like "oauth example", :twitter
  end

  context "while authenticating with Facebook Oauth" do
    it_behaves_like "oauth example", :facebook
  end

  context "while authenticating with Google Oauth" do
    it_behaves_like "oauth example", :google
  end
end
