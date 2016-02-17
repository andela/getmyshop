module OrdersHelper
  def check_address_errors
    if @address.errors.any?
      render partial: "address_errors"
    end
  end
end
