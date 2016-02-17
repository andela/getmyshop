require "rails_helper"

RSpec.describe Address, type: :model do
  let(:address) { build(:address) }

  it "has a valid factory" do
    expect(address).to be_valid
  end
end
