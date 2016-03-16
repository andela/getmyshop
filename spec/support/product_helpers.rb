module ProductHelpers
  def assemble_product
    product = create :product, subcategory: assemble_subcategory
    create_image_for_product(product)

    product
  end

  def assemble_subcategory
    create :subcategory, category: create(:category)
  end

  def create_image_for_product(product)
    create :product_image_link, product: product
  end

  def add_products_to_cart
    @products.each do |product|
      visit product_path(product)
      click_button "ADD TO CART"
      expect(page).to have_button("ADD TO CART")
    end
  end
end
