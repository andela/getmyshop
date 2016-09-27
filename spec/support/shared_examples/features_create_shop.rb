RSpec.shared_examples "features create shop" do
  let(:shopowner) { create :shop_owner, verified: true }
  let(:shop) { shopowner.shop }

  before(:each) { visit shop_path(shop.url) }
end
