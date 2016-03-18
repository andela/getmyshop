module ProductHelpers
  def add_products_to_cart
    @products.each do |product|
      visit product_path(product)
      click_button "ADD TO CART"
      expect(page).to have_button("ADD TO CART")
    end
  end
end
