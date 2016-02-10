class SearchController < ApplicationController
  def result
    products = Product.limit(10)
    @search_products = products.paginate(
      page: params[:page],
      per_page: 8
    )
  end
end
