class OrderMailer < ApplicationMailer
  def confirmation_email(order, subject)
    mail(to: order.user.email, subject: subject)
  end
end
