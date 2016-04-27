class OrdersController < ApplicationController
  include CheckLoginConcern
  before_action :check_login, except: [:paypal_hook]
  protect_from_forgery except: [:paypal_hook]

  def address
    session[current_user.id] ||= {}
    session[current_user.id]["order"] = order_params
    @user_addresses = current_user.addresses
  end

  def get_or_create_address(address_id)
    if address_id
      Address.find_by(id: address_id)
    else
      address = Address.create(address_params)
      address
    end
  end

  def summary
    address_id = params[:address_id] || session[:address_id]
    @user_address = get_or_create_address(address_id)
    session[current_user.id]["address"] = @user_address
    @order = Order.new(session[current_user.id]["order"])
  end

  def payment
  end

  def post_payment
    finalize_order_and_redirect
  end

  def finalize_order_and_redirect
    address, order = store_order_information

    if address && order
      case params[:type]
      when "pay-on-delivery"
        redirect_to confirmation_orders_path
      when "paypal"
        redirect_to order.paypal_url(confirmation_orders_path)
      else
        # put 3rd option here
        redirect_to :back
      end
    else
      redirect_to :back, notice: "Could not create your order."
    end
  end

  def clear_cart
    session[current_user.id]["address"] = nil
    session[current_user.id]["order"] = nil
    cookies.delete(:cart)
  end

  def store_order_information
    my_address = session[current_user.id]["address"]

    order = current_user.orders.create(
      session[current_user.id]["order"].merge(
        address_id: my_address["id"],
        payment_method: params[:type],
        total_amount: cookies[:total_amount]
      )
    )
    [my_address, order]
  end

  def confirmation
    clear_cart
    order = current_user.orders.last
    Stock.new(order).update
    OrderMailer.confirmation_email(
      order,
      "Your new Order #{order.order_number}"
    ).deliver_now
  end

  def order_params
    params.require(:order).permit(
      :total_amount,
      order_items_attributes: [:order_id, :product_id, :quantity, :size]
    )
  end

  def address_params
    params.permit(
      :id,
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

  def past_orders
    OrderStatus.new(current_user).save
    @past_orders = current_user.orders
  end

  def paypal_hook
    params.permit!
    status = params[:payment_status]
    if status
      order = Order.find params[:invoice]
      order.update_attributes(
        notification_params: params,
        status: status,
        transaction_id: params[:txn_id],
        purchased_at: Time.now
      )
    else
      raise "Your paypal payment wasn't successful"
    end
    render nothing: true
  end

  def destroy
    @order = Order.find(params[:id])
    unless @order.status == "Delivered"
      @order.destroy
      flash[:error] = "Order cancelled"
      redirect_to "/orders/past_orders"
    end
  end
end
