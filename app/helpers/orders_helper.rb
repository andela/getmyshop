module OrdersHelper
  def check_address_errors
    if @address.errors.any?
      render partial: "address_errors"
    end
  end

  def order_page
    if @past_orders.any?
      render partial: "orders_display"
    else
      render partial: "no_orders_display"
    end
  end

  def check_address_exist
    if @user_addresses.any?
      render partial: "old_addresses"
    else
      render partial: "no_address"
    end
  end

  def cancel_order(order)
    render "orders/cancel_order_button", order: order unless
    order.status == "Delivered"
  end
end
