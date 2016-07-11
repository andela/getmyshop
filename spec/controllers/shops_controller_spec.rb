require "rails_helper"

RSpec.describe ShopsController, type: :controller do
  before(:each) do
    @shop_owner = create(:shop_owner)
    @shop = create(:shop)
    @shop_owner.update(shop: @shop)
  end

  let(:valid_attributes) do
    @shop.attributes.merge(shop_owner_id: @shop_owner.id)
  end

  let(:invalid_attributes) do
    { name: "Shop Name" }.merge(shop_owner_id: @shop_owner.id)
  end

  describe "GET #show" do
    it "assigns the requested shop as @shop" do
      get :show, shop_owner_id: @shop_owner.id
      expect(assigns(:shop)).to eq(@shop)
    end
  end

  describe "GET #new" do
    it "assigns a new shop as @shop" do
      get :new, shop_owner_id: @shop_owner.id
      expect(assigns(:shop)).to be_a_new(Shop)
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new Shop" do
        valid_attributes[:name] = "Electronics"
        valid_attributes[:url] = "valid.com"
        expect do
          post :create, shop: valid_attributes
        end.to change(Shop, :count).by(1)
      end

      it "assigns a newly created shop as @shop" do
        post :create, shop: valid_attributes
        expect(assigns(:shop)).to be_a(Shop)
      end
    end

    context "with invalid params" do
      it "assigns a newly created but unsaved shop as @shop" do
        post :create, shop: invalid_attributes
        expect(assigns(:shop)).to be_a_new(Shop)
      end

      it "re-renders the 'new' template" do
        post :create, shop: invalid_attributes
        expect(response).to render_template("new")
      end
    end
  end
end
