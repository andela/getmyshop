class CategoriesController < ApplicationController
  include FilterrificInitializeConcern

  DEFAULT_LIMIT = 16

  def index
    @subcategories = Subcategory.get_unique
    filterrific_initialize
  end

  def show
    return report_error("Category not present.") unless category
    products = get_products
    paginate_products products
    @subcategories = Subcategory.get_unique
    filterrific_initialize
  end

  private

  def get_products
    unless subcategory_id.nil?
      return report_error("Subcategory not present.") unless subcategory
      subcategory.products
    else
      category.products
    end
  end

  def category
    @category ||= Category.find_by_id(category_id)
  end

  def subcategory
    @subcategory ||= Subcategory.find_by_id(subcategory_id)
  end

  def category_id
    if params[:category_id].present?
      params[:category_id]
    else
      params[:id]
    end
  end

  def subcategory_id
    if params[:category_id].present?
      params[:id]
    else
      nil
    end
  end

  def report_error(message)
    flash[:error] = message 
    redirect_to root_path
  end

  def paginate_products(product_collection)
    @product_list = product_collection.paginate(
      page: params[:page],
      per_page: DEFAULT_LIMIT
    )
    @result_length = product_collection.length
  end
end
