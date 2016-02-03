require "rails_helper"

RSpec.describe OrderItem, type: :model do
  let(:order_item) { build(:order_item) }

  it "has a valid factory" do
    expect(order_item).to be_valid
  end
end
