require "rails_helper"

RSpec.describe Category, type: :model do
  let(:category) do
    build(:category)
  end
  context "when initializing product category" do
    it "is successful when all arguments are correct" do
      expect(category).to be_valid
    end

    it "fails when arguments are incorrect" do
      category.name = nil
      expect(category).to be_invalid
    end
  end
end
