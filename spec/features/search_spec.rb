require "rails_helper"
require "support/search_helper"

include SearchHelper

RSpec.describe "Search Process", type: :feature do
  include_examples "features create shop"

  feature "when search finds a match" do
    before(:all) do
      create(:product, name: "testproduct1")
      create(:product, name: "testproduct2")
      sleep 3
    end

    after(:all) { DatabaseCleaner.clean_with(:truncation) }

    scenario "displays matching products with full match term", js: true do
      fill_and_search(Product.last.name)
      expect(page).to have_content Product.last.name
    end

    scenario "displays matching products with partial match term", js: true do
      fill_and_search("test")
      expect(page).to have_content "testproduct1"
      expect(page).to have_content "testproduct2"
    end
  end

  feature "when search does not find a match" do
    scenario "renders noresult partial", js: true do
      fill_and_search("jhhvjvjvcjvw")
      expect(page).to have_content "NO RESULT FOUND"
    end
  end
end
