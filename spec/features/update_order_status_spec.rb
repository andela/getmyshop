require "rails_helper"
# require "support/database_cleaner"

RSpec.describe "Updating Order Status", type: :feature do
  before(:each) do
    @shop_owner = create :shop_owner
    @shop_owner.update(verified: true)
    @orders = create_list(:order, 10, status: "Pending", shop: @shop_owner.shop)
    shop_owner_signin_helper(@shop_owner.email, "password")
    DatabaseCleaner.strategy = :truncation
  end

  after(:each){ DatabaseCleaner.clean_with(:truncation) }


  context "when an order status is changed from select box" do
    it "updates the order status", js: true do
      binding.pry
      visit admin_shop_orders_path
      page.execute_script("$('select').val('Completed')")
      find('.update-btn').click
      wait_for_ajax
      @orders.first.reload

      expect(@orders.first.status).to eql("Completed")
    end
  end

  context "when multiple orders are changed using the checkbox" do
    it "updates the order status of all marked orders", js: true do
      visit admin_shop_orders_path
      page.execute_script("$('.order-check').attr('checked', true)")
      page.execute_script("setOrderStatus('Completed')")
      wait_for_ajax
      @orders.each(&:reload)
      
      expect(@orders.map(&:status)).to match_array(["Completed"]* @orders.size)
    end
  end
end
