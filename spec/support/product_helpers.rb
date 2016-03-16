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
end
