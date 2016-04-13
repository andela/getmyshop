class OrdersController
  class StockCounter
    def initialize(order)
      @order = order
    end

    def update
      @order.order_items.each do |order_item|
        product = Product.find(order_item.product_id)
        next if product.quantity <= 0
        product.quantity -= order_item.quantity
        product.save
      end
    end
  end
end
