class ApplicationMailer < ActionMailer::Base
  default from: "GetMyShop<noreply@getmyshop.herokuapp.com>"
  layout "mailer"
end
