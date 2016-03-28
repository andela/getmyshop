class CartsController < ApplicationController
  def index
    @order = Order.new
    cart = convert_cart_cookies_to_hash
    build_order_items(cart)
  end

  def convert_cart_cookies_to_hash
    cart = cookies[:cart] ? JSON.parse(cookies[:cart]) : {}
    cart.with_indifferent_access
  end

  def build_order_items(cart)
    @total_amount = 0
    cart.each do |item_id, value|
      product = Product.find(item_id)
      @total_amount += product.price.to_i * value[:quantity].to_i
      @order.order_items.build(
        product_id: value[:item_id],
        quantity: value[:quantity].to_i,
        size: value[:size]
      )
    end
  end

  def add_item
    cart = convert_cart_cookies_to_hash

    if cart && cart.key?(item_params[:item_id])
      cart[item_params[:item_id]][:quantity] += item_params[:quantity]
    else
      cart[item_params[:item_id]] = item_params
    end

    @item = set_item_attributes(cart)
    set_cookies_and_response(cart)
  end

  def set_item_attributes(cart)
    item = params
    item[:quantity] = cart[item_params[:item_id]][:quantity]
    item[:price] = cart[item_params[:item_id]][:quantity] * item[:price].to_i
    item
  end

  def set_cookies_and_response(cart)
    @total_items = cart.size
    @total_amount = cart.values.inject(0) do |amount, item|
      price = Product.find(item[:item_id]).price.to_i
      amount + (price * item[:quantity])
    end
    cookies[:total_amount] = @total_amount.to_f
    cookies[:cart] = JSON.generate(cart)
    render_js_response
  end

  def render_js_response
    respond_to do |format|
      format.html
      format.js
    end
  end

  def delete_item
    @cart = convert_cart_cookies_to_hash
    @deleted_item = @cart.delete(params[:id])
    set_cookies_and_response(@cart)
  end

  def update_item
    cart = convert_cart_cookies_to_hash
    cart[params[:id]][:quantity] = params[:quantity].to_i
    cookies[:cart] = JSON.generate(cart)
    render json: { message: "Item updated" }
  end

  def delete_all
    cookies.delete(:cart)
    render_js_response
  end

  def item_params
    {
      item_id: params[:product_id],
      quantity: params[:quantity].to_i,
      size: params[:size]
    }
  end
end
