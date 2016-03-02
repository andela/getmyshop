require "rails_helper"

RSpec.describe Order, type: :model do
  subject { build(:order) }

  describe "has a valid factory" do
    it { is_expected.to be_valid }
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
end
