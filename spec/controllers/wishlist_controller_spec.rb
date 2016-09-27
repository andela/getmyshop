require "rails_helper"
require "support/wishlist_helpers"
require "support/product_helpers"

include ProductHelpers
include WishlistHelpers

RSpec.describe WishlistController do
  include_examples "create shop"
  before(:all) do
    @test_user = create(:regular_user)
    @test_product = create(:product)
  end

  after(:all) { DatabaseCleaner.clean_with(:truncation) }

  describe "Visiting the Wishlist index page" do
    context "when user is not signed in" do
      before(:each) { get :index }

      it_behaves_like "a controller authorization error"
    end

    context "when user is signed in" do
      it "renders template for wishlist index page" do
        session[:user_id] = @test_user.id
        get :index

        expect(response).to render_template :index
      end
    end
  end

  describe "Adding items to Wishlist" do
    context "when user is not signed in" do
      before(:each) do
        post :update,
             edit_action: "add",
             user_id: @test_user.id,
             product_id: @test_product.id
      end

      it_behaves_like "a controller authorization error"
    end

    context "when user is signed in" do
      before(:each) do
        session[:user_id] = @test_user.id
      end

      it "saves product to wishlist" do
        post(
          :update,
          edit_action: "add",
          user_id: @test_user.id,
          product_id: @test_product.id
        )
        expect(response.body).to eql "Product added Successfully"
      end

      it "fails to save a product already added to wishlist" do
        create(:wishlist, user: @test_user, product: @test_product)
        post :update,
             edit_action: "add",
             user_id: @test_user.id,
             product_id: @test_product.id

        expect(response.body).to eql "Product already exists in Wishlist"
      end
    end
  end

  describe "Deleting items from Wishlist" do
    before(:each) do
      session[:user_id] = @test_user.id
      create(:wishlist, user: @test_user, product: @test_product)
    end

    let(:wishlist) { Wishlist.last }

    it "item is deleted Successfully" do
      post :update, edit_action: "delete", wishlist_id: wishlist.id

      expect(response.body).to eql "Product removed Successfully"
    end
  end
end
