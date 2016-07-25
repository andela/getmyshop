require "rails_helper"

RSpec.describe ProductsController, type: :controller do
  let(:user) { create(:regular_user) }
  before do
    @product_one = create(:product, name: "testproduct1")
    @product_two = create(:product, name: "testproduct2")
    @shop_owner = create(:shop_owner)
    session[:shop_owner_id] = @shop_owner.id
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
        params = { product: product.attributes }
        post :create, params
        expect(response).to redirect_to(shop_products_path(@shop_owner))
      end
    end

    context "when all required product details are not filled" do
      it "renders the new template with form errors" do
        product = build(:product, quantity: nil)
        invalid_product_attributes = product.attributes
        params = { product: invalid_product_attributes }
        post :create, params
        expect(response).to render_template(:new)
      end
    end
  end
end
