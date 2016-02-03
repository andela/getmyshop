require "rails_helper"

RSpec.describe OrdersHelper, type: :helper do
  describe "address_has_errors" do
    it "returns nil when @address has no errors" do
      @address = build(:address)
      expect(check_address_errors).to be_nil
    end
  end
end
