require "rails_helper"

RSpec.describe OrdersHelper, type: :helper do
  describe "#address_has_errors" do
    it "returns nil when @address has no errors" do
      @address = build(:address)
      expect(check_address_errors).to be_nil
    end
  end

  describe "delivery tracking" do
    let(:order) {create(:order)}

    it "should return order created status when order is completed" do
      expect(helper.tracking(order.created_at)).to eq("Order Created")
    end

    it "should return pending status after 4 hours" do
      time_now = order.created_at - 5.hour
      expect(helper.tracking(time_now)).to eq("Created")
    end


    it "should return processing status after 8 hours" do
      time_now = order.created_at - 9.hour
      expect(helper.tracking(time_now)).to eq("Processing")
    end


    it "should return completed status after 12 hours" do
      time_now = order.created_at - 13.hour
      expect(helper.tracking(time_now)).to eq("Orde Completed")
    end

    it "should return completed status after 16 hours" do
      time_now = order.created_at - 17.hour
      expect(helper.tracking(time_now)).to eq("Orde Delivered")
    end
  end
end
