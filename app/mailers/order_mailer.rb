class OrderMailer < ApplicationMailer
  def confirmation_email(order, subject)
    @order = order
    mail(to: @order.user.email, subject: subject)
  end
end
