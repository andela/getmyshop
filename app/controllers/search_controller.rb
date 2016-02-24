class SearchController < ApplicationController
  def result
    @products = Product.search(params[:term])
    @search_term = params[:term]
    @search_products = @products.paginate(
      page: params[:page],
      per_page: 8
    )
  end
end
