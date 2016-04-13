require "rails_helper"

RSpec.describe OrdersController::StockCounter do
  before(:all) do
    @order = create(:order_with_items)
  end

  describe "#new" do
    it "should create a new instance of stock" do
      expect(OrdersController::StockCounter.new(@order)).to be_an_instance_of(OrdersController::StockCounter)
    end
  end

  describe "#update" do
    it "should reduce order item quantity" do
      expect do
        OrdersController::StockCounter.new(@order).update
      end.to change{ @order.order_items.first.product.quantity }.by(-@order.order_items.first.quantity)
    end

    context "out of stock" do
      it "should not change the quantity of an order" do
        new_order = create(:order_with_items, 1)
        binding.pry
      end
    end
  end

end
