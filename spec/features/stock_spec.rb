require "rails_helper"

RSpec.describe "Stock", type: :feature, js: true do
  include_examples "features create shop"
  
  feature "when product is in stock" do
    scenario "should display the quantity of product(s) left" do
      order = create(:order_with_items)
      visit product_path order.order_items.first.product.id
      expect(page).to have_content(
        "#{order.order_items.first.product.quantity} left in stock"
      )
    end
  end

  feature "when product is out of stock" do
    scenario "should dislay 'Out of Stock' if product is out of stock" do
      product = create(:product, quantity: 0)
      new_order = create(:order)
      create(:order_item, product: product, order_id: new_order.id)
      visit product_path new_order.order_items.first.product.id
      expect(page).to have_content("Out of Stock")
    end
  end
end
