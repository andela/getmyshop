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

      xit "redirects to the created shop" do
        post :create, shop: valid_attributes
        expect(response).to redirect_to(Shop.last)
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

  describe "PUT #update" do
    context "with valid params" do
      let(:new_attributes) do
        skip("Add a hash of attributes valid for your model")
      end

      xit "updates the requested shop" do
        shop = Shop.create! valid_attributes
        put :update, { id: shop.to_param, shop: new_attributes }, valid_session
        shop.reload
        skip("Add assertions for updated state")
      end

      xit "assigns the requested shop as @shop" do
        shop = Shop.create! valid_attributes
        put :update, { id: shop.to_param, shop: valid_attributes }, valid_session
        expect(assigns(:shop)).to eq(shop)
      end

      xit "redirects to the shop" do
        shop = Shop.create! valid_attributes
        put :update, { id: shop.to_param, shop: valid_attributes }, valid_session
        expect(response).to redirect_to(shop)
      end
    end

    context "with invalid params" do
      xit "assigns the shop as @shop" do
        shop = Shop.create! valid_attributes
        put :update, { id: shop.to_param, shop: invalid_attributes }, valid_session
        expect(assigns(:shop)).to eq(shop)
      end

      xit "re-renders the 'edit' template" do
        shop = Shop.create! valid_attributes
        put :update, { id: shop.to_param, shop: invalid_attributes }, valid_session
        expect(response).to render_template("edit")
      end
    end
  end

  describe "DELETE #destroy" do
    xit "destroys the requested shop" do
      shop = Shop.create! valid_attributes
      expect do
        delete :destroy, { id: shop.to_param }, valid_session
      end.to change(Shop, :count).by(-1)
    end

    xit "redirects to the shops list" do
      shop = Shop.create! valid_attributes
      delete :destroy, { id: shop.to_param }, valid_session
      expect(response).to redirect_to(shops_url)
    end
  end
end
