require "rails_helper"
RSpec.describe SearchController, type: :controller do
  before(:all) do
    create(:product, name: "testproduct1")
    create(:product, name: "testproduct2")
  end

  describe "#result" do
    context "when there are no results" do
      it "returns no results" do
        post :result, term: "sname"
        expect(assigns(:search_products).length).to be 0
      end
    end

    context "when there are results" do
      it "returns 2 products" do
        post :result, term: "test"
        expect(assigns(:search_products).length).to be 2
      end

      it "returns one product" do
        post :result, term: "testproduct1"
        expect(assigns(:search_products).length).to be 1
      end

      it "returns one product" do
        post :result, term: "testproduct2"
        expect(assigns(:search_products).length).to be 1
      end
    end
  end
end
