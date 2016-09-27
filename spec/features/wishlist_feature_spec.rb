require "rails_helper"
require "support/product_helpers"
require "support/wishlist_helpers"

include ProductHelpers
include WishlistHelpers

RSpec.describe "Wishlist Feature", type: :feature do
  include_examples "features create shop"
  before(:all) do
    create_list(:category_with_products, 2)
    create(:regular_user)
  end

  after(:all) { DatabaseCleaner.clean_with(:truncation) }

  let(:test_user) { RegularUser.first }
  let(:test_product) { Product.first }

  describe "Visiting the Wishlist index page" do
    before(:each) do
      visit wishlist_index_path
    end
    context "when a user is not signed in" do
      it_behaves_like "an authorization error that directs to login page"
    end

    feature "when user is signed-in" do
      before(:each) do
        allow_any_instance_of(ApplicationController).
          to receive(:current_user) { test_user }

        visit wishlist_index_path
      end

      scenario "renders the wishlist index page" do
        expect(current_path).to eql wishlist_index_path
      end

      scenario "wishlist page is empty" do
        expect(page).to have_content "No items in Wishlist yet."
      end
    end
  end

  describe "Adding items to Wishlist" do
    context "when a user is not signed in" do
      before(:each) do
        visit product_path(test_product)
        click_link "Add to Wishlist"
      end

      it_behaves_like "an authorization error that directs to login page"
    end

    context "when user is signed in" do
      include_context "Wishlist Operations for signed-in users"

      it "saves items to user's wishlist", js: true do
        all_wishlists = Wishlist.user_products(test_user.id)
        expect(all_wishlists.first.product).to eql test_product
      end

      it "changes page text to Browse Wishlist", js: true do
        expect(page).to have_content "Browse Wishlist"
      end

      describe "lists product on user's wishlist page", js: true do
        include_context "Wishlist Index"

        it { is_expected.to have_link test_product.name }
        it { is_expected.to have_content test_product.price }
      end
    end
  end

  describe "Removing items from wishlist", js: true do
    include_context "Wishlist Operations for signed-in users"
    include_context "Wishlist Index"

    describe "Clicking the icon to delete product" do
      before(:each) do
        visit wishlist_index_path
        click_link "Delete"
      end

      it "removes product details from wishlist page" do
        expect(page).not_to have_content test_product.name
      end

      it "removes product from user's wishlist" do
        expect(Wishlist.user_products(test_user.id)).to be_empty
      end
    end
  end
end
