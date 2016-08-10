require "rails_helper"

RSpec.describe ProductsController, type: :controller do
  let(:user) { create(:regular_user) }
  let(:product) { create(:product) }

  before do
    @product_one = create(:product, name: "testproduct1")
    @product_two = create(:product, name: "testproduct2")
    @shop_owner = create(:shop_owner)
    session[:user_id] = @shop_owner.id
    user.update(verified: true)
  end

  after(:all) { DatabaseCleaner.clean_with(:truncation) }

  describe "making a review" do
    it "renders show template" do
      login(user)
      post :rate, title: "Nice one",
                  comment: "packaging to nice",
                  rating: 2,
                  product_id: @product_one.id,
                  format: :js

      expect(@product_one.reviews.last.title).to eq "Nice one"
    end
  end

  describe "#new" do
    it "renders the new template" do
      get :new
      expect(response).to render_template(:new)
    end
  end

  describe "#create" do
    context "when all required product details are filled" do
      it "redirects to the shop_products path" do
        product = build(:product)

        expect { post :create, product: product.attributes }.
          to change(Product, :count).by(1)
        expect(response).to redirect_to(dashboard_path)
      end
    end

    context "when all required product details are not filled" do
      it "renders the new template with form errors" do
        product = build(:product, quantity: nil)
        invalid_product_attributes = product.attributes
        expect { post :create, product: invalid_product_attributes }.
          to_not change(Product, :count)
        expect(response).to render_template(:new)
      end
    end
  end

  describe "#edit" do
    it "renders the :edit view" do
      get :edit, id: product.id
      expect(response).to render_template :edit
    end
  end

  describe "#update" do
    context "with valid details" do
      it "updates the product" do
        post :update, id: product, product: {
          name: "Television set",
          brand: "Samsung"
        }
        product.reload
        expect(product.name).to eq("Television set")
        expect(product.brand).to eq("Samsung")
        expect(response).to redirect_to dashboard_path
      end
    end

    context "with invalid details" do
      it "re-renders the :edit view" do
        put :update, id: product, product: {
          name: nil
        }
        expect(response).to render_template :edit
      end
    end
  end

  describe "#destroy" do
    context "when product id is valid" do
      it "removes the product" do
        expect { delete :destroy, id: @product_one.id }.
          to change(Product, :count).by(-1)
      end

      it "responds with a 200 http status code" do
        delete :destroy, id: @product_one.id

        expect(response.status).to eq(200)
      end
    end

    context "when product id is invalid" do
      it "returns status 404" do
        delete :destroy, id: "invalid"
        expect(response.status).to eq(404)
      end
    end
  end
end
