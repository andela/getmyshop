require "rails_helper"

RSpec.describe AddressesController, type: :request do
  before(:all) do
    @address = create(:address)
  end

  describe "POST update" do
    before(:all) do
      @params = { address: {
        name: Faker::Name.name,
        address: Faker::Address.street_address
      }
    }
    end

    before do
      patch "/addresses/#{@address.id}", @params
    end

    it "should update the address" do
      @address.reload
      expect(@address.name).to eq @params[:address][:name]
      expect(@address.address).to eq @params[:address][:address]
    end

    it "should redirect user addresses path" do
      expect(response).to redirect_to(addresses_users_path(@address.user))
    end
  end

  describe "DELETE destroy" do
    before do
      delete "/addresses/#{@address.id}"
    end

    it "should set flash message" do
      expect(flash[:success]).to eq("Address deleted")
    end

    it "should redirect user addresses path" do
      expect(response).to redirect_to(addresses_users_path(@address.user))
    end

    it "should have an archived_at date" do
      expect(Address.all.size).to eql(0)
    end
  end
end
