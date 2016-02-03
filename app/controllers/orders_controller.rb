class OrdersController < ApplicationController
  include CheckLoginConcern
  before_action :check_login

  def address
    session[current_user.id] ||= {}
    session[current_user.id]["order"] = order_params

    @address = Address.new
  end

  def summary
    @address = Address.new(address_params)
    if @address.valid?
      session[current_user.id]["address"] = @address
      @order = Order.new(session[current_user.id]["order"])
      render :summary
    else
      render :address
    end
  end

  def payment
  end

  def post_payment
    case params[:type]
    when "pay-on-delivery"
      finalize_order_and_redirect
    when "paypal"
      # redirect to paypal for payment
    else
      # invalid payment method
      redirect_to :back
    end
  end

  def finalize_order_and_redirect
    address, order = store_order_information

    if address && order
      session[current_user.id]["address"] = nil
      session[current_user.id]["order"] = nil
      redirect_to confirmation_orders_path
    else
      redirect_to :back, notice: "Could not create your order."
    end
  end

  def store_order_information
    address = current_user.addresses.create(
      session[current_user.id]["address"]
    )
    order = current_user.orders.create(
      session[current_user.id]["order"].merge(address_id: address.id)
    )

    [address, order]
  end

  def confirmation
  end

  def order_params
    params.require(:order).permit(
      :total_amount,
      order_items_attributes: [:order_id, :product_id, :quantity, :size]
    )
  end

  def address_params
    params.require(:address).permit(
      :user_id,
      :name,
      :email,
      :address,
      :landmark,
      :gender,
      :phone,
      :state,
      :city,
      :country
    )
  end
end
