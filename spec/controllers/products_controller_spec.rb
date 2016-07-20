require "rails_helper"

RSpec.describe ProductsController, type: :controller do
  let(:user) { create(:regular_user) }
  before(:all) do
    @product_one = create(:product, name: "testproduct1")
    @product_two = create(:product, name: "testproduct2")
    @shop_owner = create(:shop_owner)
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
      get :new, shop_owner_id: @shop_owner.id
      expect(response).to render_template(:new)
    end
  end

  describe "#create" do
    context "when all required product details are filled" do
      it "redirects to the shop_products path" do
        product = build(:product)
        product_attributes = product.attributes.
                             merge(shop_owner_id: @shop_owner.id)
        params = { product: product_attributes }
        post :create, params
        expect(response).to redirect_to(shop_products_path(@shop_owner))
      end
    end

    context "when all required product details are not filled" do
      it "renders the new template with form errors" do
        product = build(:product, quantity: nil)
        invalid_product_attributes = product.attributes.
                                     merge(shop_owner_id: @shop_owner.id)
        params = { product: invalid_product_attributes }
        post :create, params
        expect(response).to render_template(:new)
      end
    end
  end
end
