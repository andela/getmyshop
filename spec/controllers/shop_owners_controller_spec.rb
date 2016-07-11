require "rails_helper"

RSpec.describe ShopOwnersController, type: :controller do
  let(:valid_attributes) do
    create(:shop_owner).attributes
  end

  let(:invalid_attributes) { { first_name: "John", email: "Invalid" } }

  describe "GET #new" do
    it "assigns a new shop_owner as @shop_owner" do
      get :new
      expect(assigns(:shop_owner)).to be_a_new(ShopOwner)
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new ShopOwner" do
        expect do
          post :create, shop_owner: valid_attributes
        end.to change(ShopOwner, :count).by(1)
      end

      it "assigns a newly created shop_owner as @shop_owner" do
        post :create, shop_owner: valid_attributes
        expect(assigns(:shop_owner)).to be_a(ShopOwner)
      end
    end

    context "with invalid params" do
      it "assigns a newly created but unsaved shop_owner as @shop_owner" do
        post :create, shop_owner: invalid_attributes
        expect(assigns(:shop_owner)).to be_a_new(ShopOwner)
      end

      it "re-renders the 'new' template" do
        post :create, shop_owner: invalid_attributes
        expect(response).to render_template("new")
      end
    end
  end
end
