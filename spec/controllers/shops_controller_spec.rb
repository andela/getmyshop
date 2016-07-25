require "rails_helper"

RSpec.describe ShopsController, type: :controller do
  before(:each) do
    @shop_owner = create(:shop_owner)
    @shop = @shop_owner.shop
    session[:shop_owner_id] = @shop_owner.id
  end

  let(:valid_attributes) do
    @shop.attributes
  end

  let(:invalid_attributes) do
    { name: "Shop Name" }
  end

  describe "#show" do
    it "assigns the requested shop as @shop" do
      get :show, shop_owner_id: @shop_owner.id
      expect(assigns(:shop)).to eq(@shop)
    end
  end

  describe "#new" do
    it "assigns a new shop as @shop" do
      get :new, shop_owner_id: @shop_owner.id
      expect(assigns(:shop)).to be_a_new(Shop)
    end
  end

  describe "#create" do
    context "with valid params" do
      it "creates a new Shop" do
        valid_attributes[:name] = "Electronics"
        valid_attributes[:url] = "valid.com"
        expect do
          post :create, shop: valid_attributes
        end.to change(Shop, :count).by(1)
        expect(assigns(:shop)).to be_a(Shop)
      end
    end

    context "with invalid params" do
      it "re-renders the 'new' template" do
        post :create, shop: invalid_attributes
        expect(response).to render_template("new")
      end
    end
  end

  describe "#products" do
    it "assigns the products instance to the products template" do
      get :products, shop_owner_id: @shop_owner.id
      expect(response).to render_template("products")
      expect(assigns(:products)).to match_array(@shop_owner.shop.products)
    end
  end
end
