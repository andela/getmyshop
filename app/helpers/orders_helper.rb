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

  def tracking(t)
    time = Time.now.to_i
    if time.between?(t.to_i, (t + 4.hour).to_i)
      "Order Created"
    elsif time.between?((t + 4.hour).to_i, (t + 8.hour).to_i)
        "Pending"
    elsif time.between?((t + 8.hour).to_i, (t + 12.hour).to_i)
      "Processing"
    elsif time.between?((t + 12.hour).to_i, (t + 16.hour).to_i)
      "Completed"
    else
      "Delivered"
    end
  end
end
