require "rails_helper"
require "support/search_helper"

include SearchHelper

RSpec.describe "Search Process", type: :feature do
  context "when search finds a match" do
    before(:all) do
      create(:product, name: "testproduct1")
      create(:product, name: "testproduct2")
    end
    it "displays matching products with full match term", js: true do
      fill_and_search(Product.last.name)
      expect(page).to have_content Product.last.name
    end

    it "displays matching products with partial match term", js: true do
      fill_and_search("test")
      expect(page).to have_content "testproduct1"
      expect(page).to have_content "testproduct2"
    end
  end

  context "when search does not find a match" do
    it "renders noresult partial", js: true do
      fill_and_search("jhhvjvjvcjvw")
      expect(page).to have_content "NO RESULT FOUND"
    end
  end
end
