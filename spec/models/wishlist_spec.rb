require "rails_helper"

RSpec.describe Wishlist, type: :model do
  subject do
    create :wishlist, product: create(:product), user: create(:regular_user)
  end

  describe "when initialized" do
    it { is_expected.to be_valid }
    it { is_expected.to be_an_instance_of Wishlist }

    context "responds to instance method calls" do
      it { is_expected.to respond_to :product }
      it { is_expected.to respond_to :user }
    end

    it "is associated with a product" do
      expect(subject.product).not_to be_nil
    end

    it "is listed under the user's list of wishlists" do
      expect(Wishlist.user_products(subject.user_id)).to include subject
    end
  end

  describe "when deleted" do
    before(:each) { subject.destroy }

    it "is removed from a user's list of wishlists" do
      user_id = subject.user_id
      expect(Wishlist.user_products(user_id)).to be_empty
    end

    it "ceases to exist" do
      expect(subject.exists?).to be_falsey
    end
  end
end
