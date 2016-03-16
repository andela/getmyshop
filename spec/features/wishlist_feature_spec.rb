require "rails_helper"
require "support/product_helpers"
require "support/wishlist_helpers"

include ProductHelpers
include WishlistHelpers

RSpec.describe "Wishlist Feature", type: :feature do
  let(:test_user) { create(:regular_user) }
  let(:test_product) do
    product = create(:product)
    create(:product_image_link, product: product)

    product
  end

  describe "Visiting the Wishlist index page" do
    context "when a user is not signed in" do
      before(:each) { visit wishlist_index_path }

      it_behaves_like "an authorization error that directs to login page"
    end

    context "when user is signed-in" do
      before(:each) do
        signin_helper(test_user.email, test_user.password)
        visit wishlist_index_path
      end

      it "renders the wishlist index page" do
        expect(current_path).to eql wishlist_index_path
      end

      it "wishlist page is empty" do
        expect(page).to have_content "No items in Wishlist yet."
      end
    end
  end

  describe "Adding items to Wishlist" do
    context "when a user is not signed in" do
      before(:each) do
        product = test_product
        visit product_path(product)
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
