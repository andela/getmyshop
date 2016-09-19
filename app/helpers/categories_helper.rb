module CategoriesHelper
  def category_name
    return @subcategory.name if @subcategory
    @category.name
  end

  def category_breadcrumb
    output = "#{link_to 'Home', root_path,\
      class: @shop.color+'-text'}<span>&nbsp;»&nbsp;</span>\
      #{link_to @category.name, category_path(@category.id),\
      class: @shop.color+'-text'}
    "
    output << "<span>&nbsp;»&nbsp;</span>#{@subcategory.name}" if @subcategory
    output.html_safe
  end

  def report_not_found
    unless flash.empty?
      output = "<div class='container'><div class='row'>\
                <div class='col s12 l12 m12 red darken-2'>"
      flash.each do |_key, value|
        output << "<p class='center-align white-text'>#{value}</p>"
      end
      output << "</div></div></div>"
      output.html_safe
    end
  end
end
