require "rails_helper"
RSpec.describe SearchController, type: :controller do
  include_examples "create shop"
  before(:all) do
    create(:product, name: "testproduct1")
    create(:product, name: "testproduct2")
  end

  after(:all) { DatabaseCleaner.clean_with(:truncation) }

  describe "#result" do
    context "when there are no results" do
      it "returns no results" do
        post :result, term: "sname"
        expect(assigns(:products).length).to be 0
      end
    end

    context "when there are results" do
      it "returns 2 products" do
        post :result, term: "test"
        expect(assigns(:products).length).to be 2
      end

      it "returns one product" do
        post :result, term: "testproduct1"
        expect(assigns(:products).length).to be 1
      end

      it "returns one product" do
        post :result, term: "testproduct2"
        expect(assigns(:products).length).to be 1
      end

      context "when searching by product brand" do
        let(:brand) { Product.first.brand }
        before(:each) { post :result, term: brand }
        subject { response }

        it { expect(assigns(:products)).not_to be_nil }
        it { expect(assigns(:products).count).to be >= 1 }

        it { is_expected.to render_template(:result) }
        it { is_expected.to have_http_status(200) }
      end
    end
  end
end
