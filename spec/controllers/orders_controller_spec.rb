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
             address: create(:address),
             payment_method: "paypal"
    end

    context "unsuccessful payment" do
      it "raises error if payment was not successful" do
        expect { post :paypal_hook }.to raise_error do |error|
          expect(error).to be_a RuntimeError
        end
      end
    end

    context "successful payment" do
      it "updates the order status to `Completed`" do
        post :paypal_hook, "mc_gross" => order.total_amount.to_i / 100,
                           "invoice" => order.id,
                           "address_status" => "confirmed",
                           "address_street" => order.address,
                           "payment_status" => "Completed",
                           "type" => "Completed",
                           "address_name" => "address name",
                           "verify_sign" => "AXRgIKi50FXdGRGh8D815JH-"\
                           "YEftIeF9KOlO6Gi33F4OFxtUxjfFhG58",
                           "payer_email" => order.user.email,
                           "txn_id" => "83E55482L7753931W",
                           "receiver_email" => order.user.email
        order.reload
        expect(order.status).to eq "Completed"
      end
    end
  end

  describe "PUT #update" do
    before(:all){ @order = create(:order, status: "Pending") }
    
    it "updates the order status" do
      order_status = {}
      order_status["#{@order.id}"] = { status: "Completed" }
      put :update, { orders: order_status }
      @order.reload

      expect(@order.status).to eq("Completed")
    end
  end
end
