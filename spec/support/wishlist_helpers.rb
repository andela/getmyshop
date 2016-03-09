module WishlistHelpers
  shared_context "Wishlist Operations for signed-in users" do
    before(:all) do
      DatabaseCleaner.strategy = :truncation, { only: %w(wishlists) }
    end

    before(:each) do
      signin_helper(@test_user.email, @test_user.password)
      visit product_path(@test_product)
      click_link "Add to Wishlist"
    end
  end

  shared_context "Wishlist Index" do
    subject do
      visit wishlist_index_path

      page
    end
  end

  shared_examples "an authorization error that directs to login page" do
    it "redirects user to login page" do
      expect(current_path).to eql login_path
    end

    it "renders an error message telling the user to login" do
      within(".error-messages") do
        expect(page).to have_content "Login required"
      end
    end
  end

  shared_examples "a controller authorization error" do
    it "raises an authorization error" do
      expect(flash[:errors]).to include "Login required."
    end

    it "redirects to login page" do
      expect(response).to redirect_to login_path
    end
  end
end
