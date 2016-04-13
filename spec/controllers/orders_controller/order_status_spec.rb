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

    it "should have shipped status after 4 hours" do
      new_order = create(:order)
      new_order.created_at = Time.now - 5.hour
      new_order.save
      result = OrdersController::OrderStatus.new(new_order.user).save
      expect(result[0].status).to eql("Shipped")
    end

    it "should have delivered status after 12 hours" do
      new_order = create(:order)
      new_order.created_at = Time.now - 13.hour
      new_order.save
      result = OrdersController::OrderStatus.new(new_order.user).save
      expect(result[0].status).to eql("Delivered")
    end

    context "when the hour range is between 4 and 12" do
      it "sets the order status to shipped" do
        new_order = create(:order)
        time = (4...12).to_a.sample
        new_order.created_at = Time.now - time.hour
        new_order.save
        result = OrdersController::OrderStatus.new(new_order.user).save
        expect(result[0].status).to eql("Shipped")
      end
    end

    context "when the hour range is from 12 upwards" do
      it "sets the order status to delivered" do
        new_order = create(:order)
        time = (12...24).to_a.sample
        new_order.created_at = Time.now - time.hour
        new_order.save
        result = OrdersController::OrderStatus.new(new_order.user).save
        expect(result[0].status).to eql("Delivered")
      end
    end
  end
end
