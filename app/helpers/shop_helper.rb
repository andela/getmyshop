module ShopHelper
  def shop_form_errors(errors)
    errors.map.with_index(1) do |e, i|
      "<span class='shop-error'>#{i}. #{e}</span><br/>"
    end.join
  end

  def theme_options(shop_color)
    colors = %w(red blue pink black amber brown lime
                teal indigo deep-purple deep-orange purple cyan)
    colors.map do |val|
      [
        "<option value='#{val}'",
        ("selected" if shop_color == val) || "",
       ">#{val.capitalize}</option>"
     ].join
    end.join.html_safe
  end
end
