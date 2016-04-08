class OrdersController
  class OrderStatus
    def initialize(current_user)
      @current_user = current_user
    end

    def save
      @current_user.orders.each do |order|
        next if order.status == "Delivered"
        status = get_status(order.created_at) || order.status
        order.update_attributes(status: status)
      end
    end

    protected

    def get_status(t)
      time = Time.now.to_i
      if time.between?((t + 4.hour).to_i, (t + 12.hour).to_i)
        "Shipped"
      elsif time.between?((t + 12.hour).to_i, (t + 16.hour).to_i)
        "Delivered"
      end
    end
  end
end
