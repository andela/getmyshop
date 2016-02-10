class CategoriesController < ApplicationController
  DEFAULT_LIMIT = 16
  def index
    all_products = Product.all
    paginate_products all_products
    @subcategories = Subcategory.get_unique
  end

  def show
    return category_not_present unless category
    category_products = category.products
    paginate_products category_products
    @subcategories = Subcategory.get_unique
  end

  def category
    @category ||= Category.find_by_id(params[:id])
  end

  def category_not_present
    flash[:error] = "Category not present."
    redirect_to root_path
  end

  def paginate_products(product_collection)
    @products = product_collection.paginate(
      page: params[:page],
      per_page: DEFAULT_LIMIT
    )
    @result_length = product_collection.length
  end
end
