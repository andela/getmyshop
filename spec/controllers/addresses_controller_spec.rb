require "rails_helper"

RSpec.describe AddressesController, type: :request do
  before(:all) do
    @address = create(:address)
  end

  describe "POST update" do
    before do
      patch "/addresses/#{@address.id}", {
        address: { name: "James Longo", address: "1 Aso Rock" }
      }
    end

    it "should update the address" do
      @address.reload
      expect(@address.name).to eq "James Longo"
      expect(@address.address).to eq "1 Aso Rock"
    end

    it "should redirect user to cart summary page" do
      expect(response).to redirect_to("/orders/summary/#{@address.id}")
    end
  end

  describe "DELETE destroy" do
    before do
      delete "/addresses/#{@address.id}"
    end

    it "should set flash message" do
      expect(flash[:success]).to eq("Address deleted")
    end

    it "should redirect user to cart page" do
      expect(response).to redirect_to(cart_path)
    end

    it "should have an archived_at date" do
      @address.reload
      expect(@address.archived_at).to be_truthy
    end
  end
end
