require "rails_helper"

RSpec.describe ShopsController, type: :controller do
  describe "signup page" do
    context "when user requests signup url" do
      it "returns a 200 status code" do
        get :new
        expect(response.status).to eql(200)
        expect(response).to render_template(:new)
      end
    end
  end
end
