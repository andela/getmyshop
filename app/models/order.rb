class Order < ActiveRecord::Base
  has_many :order_items
  belongs_to :address
  belongs_to :user
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
end
