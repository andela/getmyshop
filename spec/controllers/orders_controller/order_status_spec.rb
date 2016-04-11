require "rails_helper"

RSpec.describe OrdersController::OrderStatus do
  before(:all) do
    @order = create(:order)
  end

  describe "#new" do
    it "should be an instance of order" do
      order_status = OrdersController::OrderStatus.new(@order.user)
      expect(order_status).to be_instance_of(OrdersController::OrderStatus)
    end
  end

  describe "#save" do
    it "should have default of pending" do
      expect(@order.status).to eq("Pending")
    end
  end
end
