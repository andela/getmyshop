require "rails_helper"
require "support/order_item_helpers"

RSpec.configure do |config|
  config.include OrderItemHelpers
end

RSpec.describe OrderItem, type: :model do
  let(:order_item) { assemble_order_item }

  it "has a valid factory" do
    expect(order_item).to be_valid
  end

  it "is associated with a product when initialized" do
    expect(order_item).to respond_to :product
    expect(order_item.product).not_to be_nil
  end

  it "is associated with an order when initialized" do
    expect(order_item).to respond_to :order
    expect(order_item.order).not_to be_nil
  end

  it "has a numeric quantity value" do
    expect(order_item).to respond_to :quantity
    expect(order_item.quantity).to be_an Integer
  end

  it "has a size attribute for that specific item" do
    expect(order_item).to respond_to :size
  end
end
