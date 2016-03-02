require "support/oauth_spec_helper"
RSpec.shared_examples "oauth example" do |provider, _new_user|
  include OauthSpecHelper

  it "creates and logs in an Oauth user" do
    setup(provider)
    request.env["omniauth.auth"] = OmniAuth.config.mock_auth[provider]
    get :create, provider: provider.to_s
    expect(session[:user_id]).to eq(User.last.id)
  end

  it "Logs in an existing Oauth user" do
    user = create(:regular_user)
    setup_params = setup(provider)
    auth_params = {
      provider: setup_params.provider,
      uid: setup_params.uid,
      oauth_secret: setup_params.secret,
      oauth_token: setup_params.token,
      oauth_expires: setup_params.expires_at,
      user_id: user.id
    }
    auth_user = OauthAccount.create auth_params
    auth_user.user_id = user.id
    auth_user.save!
    request.env["omniauth.auth"] = OmniAuth.config.mock_auth[provider]
    get :create, provider: provider.to_s
    expect(session[:user_id]).to eq(User.last.id)
  end
end
