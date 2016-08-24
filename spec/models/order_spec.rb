require "rails_helper"

RSpec.describe Order, type: :model do
  subject { build(:order) }
  let(:shop) { create(:shop) }
  let(:pending_orders) { create_list(:order, 5, status: "Pending", shop: shop) }
  let(:completed_orders) do
    create_list(:order, 30, status: "Completed", shop: shop)
  end

  describe "has a valid factory" do
    it { is_expected.to be_valid }
  end

  describe "default order status" do
    it "should a default status of pending" do
      expect(subject.status).to eq "Pending"
    end
  end

  describe "instance methods" do
    context "respond to instance method calls" do
      it { is_expected.to respond_to(:order_number) }
      it { is_expected.to respond_to(:payment_method) }
      it { is_expected.to respond_to(:total_amount) }
      it { is_expected.to respond_to(:user_id) }
      it { is_expected.to respond_to(:address_id) }
    end
  end

  describe "ActiveModel Relation" do
    it { is_expected.to have_many(:order_items) }
    it { is_expected.to belong_to(:user) }
    it { is_expected.to belong_to(:address) }
  end

  describe "Nested Attribute" do
    it { is_expected.to accept_nested_attributes_for(:order_items) }
  end

  describe "#paypal_url" do
    before(:each) do
      allow(ENV).to receive(:[]).with("paypal_host").
        and_return("https://sandbox.paypal.com")
      allow(ENV).to receive(:[]).with("PAYPAL_BUSINESS").
        and_return("notify@email.com")
      allow(ENV).to receive(:[]).with("app_host").
        and_return("http://sample.com")
      allow(ENV).to receive(:[]).with("paypal_notify_url").
        and_return("http://sample.com/notify")
    end

    it "returns appropriate paypal url with return path" do
      expect(subject.paypal_url("/getmyshop")).to eql(
        "#{ENV['paypal_host']}/cgi-bin/webscr?amount=#{subject.total_amount}"\
        "&business=notify%40email.com&cmd=_xclick&invoice="\
        "#{subject.id}&item_name=Receipt+for+Order+"\
        "#{subject.order_number}&item_number=#{subject.order_number}"\
        "&notify_url=http%3A%2F%2Fsample.com%2Fpaypal_hook&"\
        "return=http%3A%2F%2Fsample.com%2Fgetmyshop&upload=1"
      )
    end
  end

  describe "#build_order_number" do
    it "returns a random order number" do
      expect(subject.build_order_number).to eql subject.order_number
    end
  end

  describe ".pending" do
    it "returns all orders with a pending status" do
      expect(Order.pending(shop)).to match_array(pending_orders)
    end
  end

  describe ".completed" do
    it "returns all orders with a completed status" do
      expect(Order.completed(shop)).to match_array(completed_orders)
    end
  end

  describe ".filter" do
    context "when filter tag is 'completed'" do
      it "returns all Completed orders" do
        expect(Order.filter("completed")).to match_array(completed_orders)
      end
    end

    context "when filter tag is 'pending'" do
      it "returns all Pending Orders" do
        expect(Order.filter("pending")).to match_array(pending_orders)
      end
    end

    context "when no filter tag is given" do
      it "returns all Orders" do
        expect(Order.filter).to match_array(shop.orders)
      end
    end
  end
end
