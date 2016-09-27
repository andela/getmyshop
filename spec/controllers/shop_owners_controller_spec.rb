require "rails_helper"

RSpec.describe ShopOwnersController, type: :controller do
  include_examples "create shop"

  let(:name) { Faker::Company.name }

  let(:shop_) do
    attributes_for(:shop, {
      name: name,
      url: name.downcase.gsub(/\s/, "")
      })
  end

  let(:valid_attributes) do
    attributes_for(:shop_owner, {
      first_name: Faker::Name.name,
      last_name: Faker::Name.name,
      phone: Faker::PhoneNumber.phone_number,
      email: Faker::Internet.email,
      shop: shop_
      })
  end

  let(:invalid_attributes) { { first_name: "John", email: "Invalid" } }

  describe "GET #new" do
    it "assigns a new shop_owner as @shop_owner" do
      get :new
      expect(assigns(:shop_owner)).to be_a_new(ShopOwner)
    end
  end

  describe "#shop_owner_activate" do
    it "turns the shop owner's active_status to true" do
      get :shop_owner_activate, token: shopowner.generate_token
      shopowner.reload
      expect(shopowner.verified).to be_truthy
      expect(session[:admin_id]).to eq shopowner.id
      expect(response).to redirect_to shop_new_path
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new ShopOwner" do
        expect do
          post :create, shop_owner: valid_attributes
        end.to change(ShopOwner, :count).by(1)
        expect(assigns(:shop_owner)).to be_a(ShopOwner)
      end
    end

    context "with invalid params" do
      it "re-renders the new template with errors" do
        post :create, shop_owner: invalid_attributes
        expect(response).to render_template("new")
      end
    end
  end
end
