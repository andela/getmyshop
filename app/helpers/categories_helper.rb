module CategoriesHelper
  def category_name
    if @subcategory && @category
      @subcategory.name
    else
      @category.name
    end
  end

  def category_breadcrumb
    output = ""
    output += link_to "Home", root_path
    output += "<span>&nbsp;»&nbsp;</span>"
    output += link_to @category.name, category_path(@category.id)
    if @subcategory
      output += "<span>&nbsp;»&nbsp;</span>"
      output += @subcategory.name
    end
    output.html_safe
  end
end
