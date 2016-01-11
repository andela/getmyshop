require "rails_helper"

describe Product, type: :model do
  let(:product) { build(:product) }

  context "when product is initialized" do
    it "is valid when name is lesser than 60 characters" do
      expect(product).to be_valid
    end

    it "is invalid when name is greater than 60 characters" do
      product.name = "funmi.js" * 12
      expect(product).to be_invalid
    end

    it "is invalid when name is empty" do
      product.name = nil
      expect(product).to be_invalid
    end

    it "is invalid when price is not numeric" do
      product.price = "23er5"
      expect(product).to be_invalid
    end

    it "is invalid when price is nil" do
      product.price = nil
      expect(product).to be_invalid
    end

    it "is invalid when description is nil" do
      product.description = nil
      expect(product).to be_invalid
    end

    it "is invalid when quantity is nil" do
      product.quantity = nil
      expect(product).to be_invalid
    end
  end
end
