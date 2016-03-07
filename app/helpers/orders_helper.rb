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
end
