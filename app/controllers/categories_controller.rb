class CategoriesController < ApplicationController
  include FilterrificInitializeConcern

  DEFAULT_LIMIT = 16

  def index
    paginate_products(Product.all)
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
    if subcategory.nil?
      if params[:category_id].present?
        report_error("Subcategory not present.", false)
      end
      category.products
    else
      subcategory.products
    end
  end

  def category
    @category ||= Category.find_by(id: category_id)
  end

  def subcategory
    @subcategory ||= category.subcategories.find_by(id: subcategory_id)
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
    end
  end

  def report_error(message, redirect = true)
    flash.now[:error] = message
    redirect_to categories_path if redirect
  end

  def paginate_products(product_collection)
    @product_list = product_collection.paginate(
      page: params[:page],
      per_page: DEFAULT_LIMIT
    )
    @result_length = product_collection.length
  end
end
