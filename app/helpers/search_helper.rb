module SearchHelper
  def show_no_result
    if @products.empty?
      render partial: "noresult"
    end
  end
end
