class SearchController < ApplicationController
  def result
    @search_term = params[:term] || get_term
    @subcategories = Subcategory.get_unique
    (@filterrific = initialize_filterrific(
      Product,
      params[:filterrific]
    )) || return
    @products = Product.filterrific_find(@filterrific).
                page(params[:page]).with_search(@search_term)
    respond_to do |format|
      format.html
      format.js
    end
  end

  def get_term
    request.referer.split("=").last.tr("+", " ").strip
  end
end
