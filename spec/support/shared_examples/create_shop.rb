RSpec.shared_examples "create shop" do
  let(:shopowner) { create :shop_owner }
  let(:shop) { shopowner.shop }
  
  before do
    session[:shop_url] = shop.url
  end
end