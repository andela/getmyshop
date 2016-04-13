class ProductDecorator < Draper::Decorator
  delegate_all

  def stock
    if object.quantity > 0
      h.content_tag(:div, "#{object.quantity} left in stock",
                    class: "stock-count")
    else
      h.content_tag(:div, "Out of Stock", class: "out-of-stock")
    end
  end
end
