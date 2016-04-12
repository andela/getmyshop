class OrdersController
  class StockCounter
    def initialize(order)
      @order = order
    end

    def save
      @order.each do |order|
        order.update_attributes(quantity: qauntity)
      end
    end
  end
end
