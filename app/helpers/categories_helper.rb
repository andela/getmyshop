module CategoriesHelper
  def category_name
    if @subcategory && @category
      @subcategory.name
    else
      @category.name
    end
  end

  def category_breadcrumb
    output = "#{link_to "Home", root_path}<span>&nbsp;»&nbsp;</span>\
    #{link_to @category.name, category_path(@category.id)}
    "
    output << "<span>&nbsp;»&nbsp;</span>#{@subcategory.name}" if @subcategory
    output.html_safe
  end
end
