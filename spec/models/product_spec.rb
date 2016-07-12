require "rails_helper"

describe Product, type: :model do
  before(:all) { DatabaseCleaner.clean_with(:truncation) }
  after(:all) { DatabaseCleaner.clean_with(:truncation) }

  context "when product is initialized" do
    let(:product) { build(:product, price: 1000) }

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

  describe "scopes used by filterrific" do
    before(:all) do
      create(:product, price: 1000)
      create(:product, price: 4000)
      create(:product, price: 6000)
    end

    let(:last_product) { Product.last }

    it "can filter by high price" do
      expect(Product.with_low_price(2000).count).to eql(2)
    end

    it "can filter by low price" do
      expect(Product.with_high_price(4000).count).to eql(2)
    end

    it "can filter by subcategory" do
      expect(Product.with_subcategory(last_product.subcategory.name).first).
        to eq(last_product)
    end

    it "can filter by category" do
      expect(Product.with_category(last_product.category.name).first).
        to eq(last_product)
    end

    it "filters with search" do
      expect(Product.with_search(last_product.name).first).to eq(last_product)
    end
  end
end
