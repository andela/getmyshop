class CategoriesController < ApplicationController
  DEFAULT_LIMIT = 16
  def show
    return category_not_present unless category
    category_products = category.products
    @products = category_products.paginate(
      page: params[:page], per_page: DEFAULT_LIMIT)
    @result_length = category_products.length
  end

  def category
    @category ||= Category.find_by_id(params[:id])
  end

  def category_not_present
    flash[:error] = "Category not present."
    redirect_to root_path
  end
end
