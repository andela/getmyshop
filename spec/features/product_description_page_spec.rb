require "rails_helper"
require "support/social_share_example"

RSpec.describe "Product Show page", type: :feature do
  context "when in the product show page" do
    before(:all) do
      create_list(:subcategory_with_products, 2)
    end

    after(:all) { DatabaseCleaner.clean_with(:truncation) }

    let(:product) { Product.first }

    before(:each) { visit product_path(product) }

    subject { page }

    describe "product details section" do
      it { is_expected.to have_content product.name }
      it { is_expected.to have_content product.brand }
      it { is_expected.to have_content product.category.name }
      it { is_expected.to have_content product.subcategory.name }

      it { is_expected.to have_selector(:link_or_button, "ADD TO CART") }
      it do
        is_expected.to have_selector(
          "img[src='#{product.product_image_links.first.link_name}']"
        )
      end

      context "product still in stock" do
        it { is_expected.to have_css(".products-input") }
      end

      context "product out of stock" do
        it do
          out_of_stock_product = create(:product, quantity: 0)
          visit product_path(out_of_stock_product)
          is_expected.to have_button("ADD TO CART", disabled: true)
        end
      end
    end

    describe "related products in the '.related-products' div" do
      let(:related_product) { product.category.products.last }

      it do
        within(:css, "div.related-products") do
          is_expected.to have_content related_product.name
        end
      end
      it do
        within(:css, "div.related-products") do
          is_expected.to have_content related_product.price
        end
      end
      it do
        within(:css, "div.related-products") do
          is_expected.to have_selector("img")
        end
      end
    end

    describe "displays the reviews for the current product" do
      let(:product_review) { product.reviews.first }
      let(:reviewer) { product_review.user }

      before(:each) do
        click_link "Reviews"
      end

      it do
        within(:css, "div#description-tabs") do
          is_expected.to have_content product_review.comment
        end
      end

      it do
        within(:css, "div#description-tabs") do
          is_expected.to have_content reviewer.first_name
        end
      end
    end

    describe "shares a product on social media" do
      context "twitter" do
        it_behaves_like "social share example", "twitter"
      end

      context "facebook" do
        it_behaves_like "social share example", "facebook"
      end

      context "google plus" do
        it_behaves_like "social share example", "google"
      end
    end

    describe "the 'add to wishlist link'" do
      context "when user is not signed in" do
        it do
          within("div.buy-now") do
            is_expected.to have_content "Add to Wishlist"
          end
        end

        it do
          within("div.buy-now") do
            is_expected.to have_selector("a[href='#{wishlist_path}']")
          end
        end
      end

      context "when user is logged in" do
        let(:user) { create(:regular_user) }

        before(:each) do
          allow_any_instance_of(ApplicationController).
            to receive(:current_user) { user }

          visit product_path(product)
        end

        context "when product is NOT in the current user's wishlist" do
          it do
            within("div.buy-now") do
              is_expected.to have_content "Add to Wishlist"
            end
          end

          it do
            within("div.buy-now") do
              is_expected.to have_selector("a[href='#']")
            end
          end
        end

        context "when product is in the current user's wishlist" do
          before(:each) do
            create(:wishlist, user: user, product: product)
            visit product_path(product)
          end

          it do
            within("div.buy-now") do
              is_expected.to have_content "Browse Wishlist"
            end
          end

          it do
            within("div.buy-now") do
              is_expected.to have_selector("a[href='#{wishlist_path}']")
            end
          end
        end
      end
    end
  end
end
