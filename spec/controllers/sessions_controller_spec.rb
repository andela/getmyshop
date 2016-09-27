require "rails_helper"
require "support/oauth_example"

RSpec.describe SessionsController do
  include_examples "create shop"
  describe "#new" do
    it "renders the right view when user attempts to sign in" do
      get :new
      expect(response).to render_template "new"
    end
  end

  describe "#shop_owner_login" do
    it "renders the right view when user attempts to sign in" do
      get :shop_owner_login
      expect(response).to render_template "shop_owner_login"
    end
  end

  describe "#create" do
    before(:each) { @user = create(:regular_user) }

    context "while authenticating user with invalid details" do
      it "raises the right error when email is not valid" do
        post :create, session: {
          email: ("invalid" + @user.email), password: @user.password
        }
        expect(flash["errors"]).to eq [MessageService.login_failure]
        expect(response).to redirect_to login_path
      end

      it "raises the right error when password is not valid" do
        post :create, session: {
          email: @user.email, password: ("invalid" + @user.password)
        }
        expect(flash["errors"]).to eq [MessageService.login_failure]
        expect(response).to redirect_to login_path
      end
    end

    context "while authenticating user with valid details" do
      it "logs the user in successfully" do
        @user.update(verified: true)

        post :create, session: {
          email: @user.email, password: "password"
        }
        expect(session[:user_id]).to eql @user.id
        expect(response).to redirect_to shop_path(session[:shop_url])
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

  describe "#shop_owner_create" do
    before(:each) { @user = shopowner }

    context "while authenticating shop owners with invalid details" do
      it "raises the right error when email is not valid" do
        post :shop_owner_create, session: {
          email: "invalid" + @user.email, password: @user.password
        }

        expect(flash["errors"]).to eq [MessageService.login_failure]
        expect(response).to redirect_to shop_owner_login_path
      end

      it "raises the right error when password is not valid" do
        post :shop_owner_create, session: {
          email: @user.email, password: "invalid password"
        }
        expect(flash["errors"]).to eq [MessageService.login_failure]
        expect(response).to redirect_to shop_owner_login_path
      end
    end

    context "while authenticating shop owners with valid details" do
      it "logs the user in successfully" do
        @user.update(verified: true)

        post :shop_owner_create, session: {
          email: @user.email, password: "password"
        }
        expect(session[:admin_id]).to eql @user.id
        expect(response).to redirect_to dashboard_path
      end
    end
  end

  describe"#shop_owner_destroy" do
    context "when user logs out" do
      it "logs the user out successfully and redirects to the login path" do
        user = shopowner
        session[:admin_id] = user.id
        delete :shop_owner_destroy, session: {
          email: user.email, password: user.password
        }
        expect(session[:user_id]).to eql nil
        expect(response).to redirect_to shop_path(shop.url)
      end
    end
  end
end
