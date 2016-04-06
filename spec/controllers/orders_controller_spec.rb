require "rails_helper"

RSpec.describe OrdersController, type: :controller do
  describe "GET #create" do
    it "returns http success" do
    end
  end

  describe "POST #paypal hook" do
    before do
      allow_any_instance_of(Order).to receive(:paypal_url).and_return(
        status: 200,
        body: "VERIFIED",
        headers: {},
        Parameters: { status: "Completed" }
      )
    end

    it "renders nothing" do
      post :paypal_hook
      expect(response.body).to be_blank
    end
  end
end
