module ShopHelper
  def shop_form_errors(errors)
    errors.map.with_index(1) do |e, i|
      "<span class='shop-error'>#{i}. #{e}</span><br/>"
    end.join
  end
end
