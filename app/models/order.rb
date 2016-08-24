class Order < ActiveRecord::Base
  has_many :order_items, dependent: :destroy
  belongs_to :address
  belongs_to :user
  belongs_to :shop
  before_create :build_order_number

  accepts_nested_attributes_for :order_items

  def paypal_url(return_path)
    values = {
      business: ENV["PAYPAL_BUSINESS"],
      cmd: "_xclick",
      upload: 1,
      return: "#{ENV['app_host']}#{return_path}",
      invoice: id,
      amount: total_amount,
      item_name: "Receipt for Order #{order_number}",
      item_number: order_number,
      notify_url: "#{ENV['app_host']}/paypal_hook"
    }
    "#{ENV['paypal_host']}/cgi-bin/webscr?" + values.to_query
  end

  def build_order_number
    self.order_number = SecureRandom.hex(6).upcase
  end

  def self.pending(shop)
    where(shop_id: shop.id, status: "Pending")
  end

  def self.completed(shop)
    where(shop_id: shop.id, status: "Completed")
  end

  def self.filter(tag = nil)
    return all if tag.nil? || tag.empty?
    tag = tag.capitalize
    where(status: tag)
  end
end
