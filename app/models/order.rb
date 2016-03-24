class Order < ActiveRecord::Base
  has_many :order_items
  belongs_to :address
  belongs_to :user

  accepts_nested_attributes_for :order_items

  # def paypal_url(return_path)
  #   values = {
  #     business: "merchant@gotealeaf.com",
  #     cmd: "_xclick",
  #     upload: 1,
  #     return: "#{Rails.application.secrets.app_host}#{return_path}",
  #     invoice: id,
  #     amount: course.price,
  #     item_name: course.name,
  #     item_number: course.id,
  #     quantity: "1"
  #   }
  #   "#{Rails.application.secrets.paypal_host}/cgi-bin/webscr?" +
  #  values.to_query
  # end

  def paypal_url(return_path)
    values = {
      business: ENV["PAYPAL_BUSINESS"],
      cmd: "_xclick",
      return: "#{ENV['app_host']}#{return_path}",
      invoice: uniq_id,
      amount: amount,
      item_name: "Ticket for #{event.title}",
      item_number: id,
      notify_url: "#{ENV['paypal_notify_url']}/paypal_hook"
    }
    "#{ENV['paypal_host']}/cgi-bin/webscr?" + values.to_query
  end
end
