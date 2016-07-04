require "rails_helper"


RSpec.describe ShopOwnersController, type: :controller do

  let(:valid_attributes) {
    create(:shop_owner).attributes
  }

  let(:invalid_attributes) { {first_name: "John", email: "Invalid"} }

  

  describe "GET #new" do
    it "assigns a new shop_owner as @shop_owner" do
      get :new
      expect(assigns(:shop_owner)).to be_a_new(ShopOwner)
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new ShopOwner" do
        expect {
          post :create, {:shop_owner => valid_attributes} }.to change(ShopOwner, :count).by(1)
      end

      it "assigns a newly created shop_owner as @shop_owner" do
        post :create, {:shop_owner => valid_attributes}
        expect(assigns(:shop_owner)).to be_a(ShopOwner)
      end
    end

    context "with invalid params" do
      it "assigns a newly created but unsaved shop_owner as @shop_owner" do
        post :create, {:shop_owner => invalid_attributes}
        expect(assigns(:shop_owner)).to be_a_new(ShopOwner)
      end

      it "re-renders the 'new' template" do
        post :create, {:shop_owner => invalid_attributes}
        expect(response).to render_template("new")
      end
    end
  end

  describe "PUT #update" do
    context "with valid params" do
      let(:new_attributes) {
        skip("Add a hash of attributes valid for your model")
      }

      xit "updates the requested shop_owner" do
        shop_owner = ShopOwner.create! valid_attributes
        put :update, {:id => shop_owner.to_param, :shop_owner => new_attributes}, valid_session
        shop_owner.reload
        skip("Add assertions for updated state")
      end

      xit "assigns the requested shop_owner as @shop_owner" do
        shop_owner = ShopOwner.create! valid_attributes
        put :update, {:id => shop_owner.to_param, :shop_owner => valid_attributes}, valid_session
        expect(assigns(:shop_owner)).to eq(shop_owner)
      end

      xit "redirects to the shop_owner" do
        shop_owner = ShopOwner.create! valid_attributes
        put :update, {:id => shop_owner.to_param, :shop_owner => valid_attributes}, valid_session
        expect(response).to redirect_to(shop_owner)
      end
    end

    context "with invalid params" do
      xit "assigns the shop_owner as @shop_owner" do
        shop_owner = ShopOwner.create! valid_attributes
        put :update, {:id => shop_owner.to_param, :shop_owner => invalid_attributes}, valid_session
        expect(assigns(:shop_owner)).to eq(shop_owner)
      end

      xit "re-renders the 'edit' template" do
        shop_owner = ShopOwner.create! valid_attributes
        put :update, {:id => shop_owner.to_param, :shop_owner => invalid_attributes}, valid_session
        expect(response).to render_template("edit")
      end
    end
  end

  describe "DELETE #destroy" do
    xit "destroys the requested shop_owner" do
      shop_owner = ShopOwner.create! valid_attributes
      expect {
        delete :destroy, {:id => shop_owner.to_param}, valid_session
      }.to change(ShopOwner, :count).by(-1)
    end

    xit "redirects to the shop_owners list" do
      shop_owner = ShopOwner.create! valid_attributes
      delete :destroy, {:id => shop_owner.to_param}, valid_session
      expect(response).to redirect_to(shop_owners_url)
    end
  end

end
