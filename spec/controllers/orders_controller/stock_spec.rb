require "rails_helper"

RSpec.describe OrdersController::Stock do
  before(:all) do
    @order = create(:order_with_items)
  end

  describe "#new" do
    it "should create a new instance of stock" do
      expect(OrdersController::Stock.new(@order)).to be_an_instance_of(
        OrdersController::Stock
      )
    end
  end

  describe "#update" do
    context "when product is in stock" do
      it "should reduce product quantity by order_item quantity" do
        expect do
          OrdersController::Stock.new(@order).update
        end.to change { @order.order_items.first.product.quantity }.by(
          -@order.order_items.first.quantity
        )
      end
    end

    context "when product is out of stock" do
      it "should not reduce product quantity by order_item quantity" do
        product = create(:product, quantity: 0)
        new_order = create(:order)
        create(:order_item, product: product, order_id: new_order.id)
        expect do
          OrdersController::Stock.new(new_order).update
        end.to change { new_order.order_items.first.product.quantity }.by(0)
      end
    end
  end
end
