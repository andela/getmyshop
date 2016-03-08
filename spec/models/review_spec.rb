require "rails_helper"

describe Review do
  subject { build(:review) }

  context "when I build the factory" do
    it { is_expected.to be_valid }
    it { is_expected.to be_an_instance_of Review }
  end

  describe "Instance Methods" do
    it { is_expected.to respond_to(:comment) }
    it { is_expected.to respond_to(:rating) }
  end

  describe "#comment" do
    it { expect(subject.comment).to be_a String }
  end

  describe "#rating" do
    let(:rating) { subject.rating }

    it { expect(rating).to be_a Integer }
    it { expect(rating).to be <= 5 }
    it { expect(rating).to be >= 0 }
  end

  describe "comment validation" do
    it { is_expected.to validate_presence_of :comment }

    context "when comment is not given" do
      subject { build(:review, comment: nil) }
      it { is_expected.to be_invalid }
    end
  end

  describe "rating validation" do
    it { is_expected.to validate_presence_of :rating }

    context "when rating is nil" do
      subject { build(:review, rating: nil) }
      it { is_expected.to be_invalid }
    end
  end

  describe "association with the User model" do
    it { is_expected.to belong_to :user }

    context "when I fetch the user object from the review" do
      it { expect(subject.user).to be_an_instance_of RegularUser }
    end
  end

  describe "association with the Product model" do
    it { is_expected.to belong_to :product }

    context "when I fetch the Product object from the review" do
      it { expect(subject.product).to be_an_instance_of Product }
    end
  end

  describe ".product_reviews" do
    let(:product) { create(:product) }
    before do
      5.times { create(:review) }
      4.times { create(:review, product: product) }
    end

    let(:product_reviews) { Review.product_reviews(product.id) }
    it { expect(product_reviews).to be_an ActiveRecord::Relation }
    it { expect(product_reviews.size).to eq 4 }
    it { expect(product_reviews.first).to an_instance_of Review }
    it { expect(product_reviews.first.product).to eq product }
  end
end
