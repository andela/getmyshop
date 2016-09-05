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

  def all_orders_count
    current_shop_owner.shop.orders.count
  end

  def page_links
    content_tag :div, style: "display: inline" do
      (1..total_pages).map do |index|
        concat(single_links(index))
      end
    end
  end

  def single_links(index)
    style_klass = params[:page].to_i == index ? "active" : ""
    style_klass = "active" if params[:page].to_i == 0 && index == 1
    content_tag(
      :li,
      link_to(index, "?page=#{index}", class: style_klass),
      class: "waves-effect"
    )
  end

  def next_link
    style_klass = params[:page].to_i == total_pages ? "hidden" : ""
    next_page = params[:page].to_i + 1
    icon = content_tag(:i, "chevron_right", class: "material-icons")
    attribute_link = content_tag(
      :a,
      icon,
      href: "?page=#{next_page}"
    )
    content_tag(:li, attribute_link, class: style_klass)
  end

  def previous_link
    style_klass = params[:page].to_i > 1 ? "" : "hidden"
    previous_page = params[:page].to_i - 1
    icon = content_tag(:i, "chevron_left", class: "material-icons")
    attribute_link = content_tag(
      :a,
      icon,
      href: "?page=#{previous_page}"
    )
    content_tag(:li, attribute_link, class: style_klass)
  end

  def total_pages
    shop = current_shop_owner.shop
    order_count = shop.orders.count / 15
    order_count += 1 if (shop.orders.count % 15) > 0
    order_count
  end
end
