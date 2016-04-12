class ProductDecorator < Draper::Decorator
  delegate_all

  def add_to_cart
    if object.quantity > 0
      h.submit_tag "ADD TO CART", class: "waves-effect btn products-input", id: "submit"
    else
      h.content_tag(:div, "Out of Stock", class: "out-of-stock")
    end
  end

  def stock
    if object.quantity > 0
      "#{object.quantity} left in stock"
    else
      h.content_tag(:div, "Out of Stock", class: "out-of-stock")
    end
  end
end
