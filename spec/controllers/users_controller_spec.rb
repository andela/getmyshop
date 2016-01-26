require "rails_helper"

RSpec.describe UsersController do
  let(:user) { create(:regular_user) }

  describe "GET activate" do
    it "turns the user's active_status to true" do
      user.update(activation_token: "abcd1234")
      get :activate, user_id: user.id, activation_token: user.activation_token

      user.reload
      expect(user.active_status).to be_truthy
      expect(session[:user_id]).to eq user.id
      expect(response).to redirect_to root_path
      user.destroy
    end
  end
end
