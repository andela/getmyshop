module CartsHelper
  def get_product_details(item_id)
    Product.find(item_id)
  end

  def order_items_form_if_exist
    if @order.order_items.first
      render partial: "order_items_form"
    else
      render partial: "no_order_item"
    end
  end
end
