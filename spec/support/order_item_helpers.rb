module OrderItemHelpers
  def assemble_order_item
    create :order_item, order: create_order, product: create(:product)
  end

  def create_order
    create :order, user: create(:regular_user), address: create(:address)
  end
end
