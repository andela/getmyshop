class UserMailer < ApplicationMailer
  def welcome(user_id, subject)
    @user = User.find(user_id)
    mail(to: @user.email, subject: subject)
  end

  def reset_password(user_id, subject)
    @user = User.find(user_id)
    mail(to: @user.email, subject: subject)
  end
end
