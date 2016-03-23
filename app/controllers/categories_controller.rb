class CategoriesController < ApplicationController
  include FilterrificInitializeConcern

  DEFAULT_LIMIT = 16
  # def index
  #   all_products = Product.all
  #   paginate_products all_products
  #   @subcategories = Subcategory.get_unique
  # end

  def index
    @subcategories = Subcategory.get_unique
    filterrific_initialize
    # @filterrific = initialize_filterrific(
    #   Product,
    #   params[:filterrific]
    # ) or return
    # @products = @filterrific.find.page(params[:page])
    # respond_to do |format|
    #   format.html
    #   format.js
    # end
  end

  def show
    return category_not_present unless category
    category_products = category.products
    paginate_products category_products
    @subcategories = Subcategory.get_unique
    filterrific_initialize
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
