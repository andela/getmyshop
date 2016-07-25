module ShopOwnersHelper
  def shop_owner_errors
    unless flash["errors"].blank?
      content_tag :div, flash_errors, class: "error-messages"
    end
  end

  private

  def flash_errors
    content_tag :ul do
      flash["errors"].map { |error| concat(content_tag(:li, error)) }
    end
  end
end
