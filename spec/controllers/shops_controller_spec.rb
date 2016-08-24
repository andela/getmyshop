require "rails_helper"

RSpec.describe ShopsController, type: :controller do
  before(:each) do
    @shop_owner = create(:shop_owner)
    @shop = @shop_owner.shop
    session[:user_id] = @shop_owner.id
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
    context "when user requests signup url" do
      it "returns a 200 status code" do
        get :new
        expect(response.status).to eql(200)
        expect(response).to render_template(:new)
      end

      it "assigns a new shop as @shop" do
        get :new, shop_owner_id: @shop_owner.id
        expect(assigns(:shop)).to be_a_new(Shop)
      end
    end
  end

  describe "#create" do
    context "with valid params" do
      it "creates a new Shop" do
        valid_attributes[:name] = "Electronics"
        valid_attributes[:url] = "valid.com"
        post :create, shop: valid_attributes
        expect(Shop.count).to eq(1)
        expect(response).to redirect_to dashboard_path
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

  describe "#edit" do
    it "renders the edit shop profile page" do
      shop = create(:shop, name: "New Shop", url: "myshop")

      get :edit, id: shop

      expect(response.status).to eql(200)
      expect(response).to render_template(:edit)
    end
  end

  describe "#update" do
    context "with valid attributes" do
      it "updates the shop profile page" do
        put :update, id: @shop, shop: {
          name: "Andela Enterprises"
        }
        @shop.reload
        expect(@shop.name).to eq "Andela Enterprises"
        expect(flash["notice"]).to eq "Account Updated"
        expect(response).to redirect_to edit_shop_path(@shop)
      end
    end

    context "with invalid attributes" do
      it "updates the shop profile page" do
        put :update, id: @shop, shop: {
          name: ""
        }
        @shop.reload
        expect(flash["errors"]).to eq ["Name can't be blank"]
        expect(response).to redirect_to edit_shop_path(@shop)
      end
    end
  end

  describe "#orders" do
    before { @shop.update(orders: create_list(:order, 30)) }

    context "when status and page params are given" do
      context "and status param is Pending" do
        it "returns orders having Pending status starting at the given page" do
          get :orders, status: "Pending", page: 1
          expect(assigns(:orders)).
            to match_array(Order.pending(@shop).paginate(page: 1, per_page: 15))
        end
      end

      context "and status param is Completed" do
        it "returns orders having completed status starting at given page" do
          get :orders, status: "Completed", page: 1
          expect(assigns(:orders)).
            to match_array(Order.completed(@shop).
              paginate(page: 1, per_page: 15))
        end
      end
    end

    context "when status param is present and page param absent" do
      it "returns orders matching the given status starting at page 1" do
        get :orders, status: "Pending"
        expect(assigns(:orders)).
          to match_array(Order.pending(@shop).paginate(page: 1, per_page: 15))
      end
    end

    context "when status param is absent and page param is present" do
      it "returns all orders starting at the specified page" do
        get :orders, page: 2
        expect(assigns(:orders)).
          to match_array(@shop.orders.paginate(page: 2, per_page: 15))
      end
    end

    context "when both status and page param are absent" do
      it "returns all orders starting at page 1" do
        get :orders
        expect(assigns(:orders)).
          to match_array(@shop.orders.paginate(page: 1, per_page: 15))
      end
    end
  end
end
