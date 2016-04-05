module FilterrificInitializeConcern
  extend ActiveSupport::Concern

  def filterrific_initialize
    (@filterrific = initialize_filterrific(
      Product,
      params[:filterrific],
      persistence_id: false
    )) || return
    @products = @filterrific.find.page(params[:page])
    respond_to do |format|
      format.html
      format.js
    end
  end
end
