require "rails_helper"

RSpec.describe OrdersController, type: :controller do
  describe "GET #create" do
    it "returns http success" do
    end
  end

  describe "POST #paypal hook" do
    let(:order) do
      create :order,
             user: create(:regular_user),
             address: create(:address)
    end

    before do
      allow_any_instance_of(Order).to receive(:paypal_url).and_return(
        status: 200,
        body: "VERIFIED",
        headers: {}
      )
    end

    it "raises error if payment was not successful" do
      expect { post :paypal_hook }.to raise_error { |error|
        expect(error).to be_a(RuntimeError)
      }
    end
  end
end
