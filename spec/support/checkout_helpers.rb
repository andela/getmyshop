require "support/product_helpers"

module CheckoutHelpers
  include ProductHelpers

  def add_products_and_checkout
    add_products_to_cart
    visit cart_index_path
    click_button "Checkout"
  end
end
