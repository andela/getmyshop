class UserMailer < ApplicationMailer
  def welcome(user_id, subject)
    @user = User.find(user_id)
    mail(to: @user.email, subject: subject)
  end

  def welcome_shop_owner(shop_owner_id, subject)
    @shop_owner = ShopOwner.find(shop_owner_id)
    mail(to: @shop_owner.email, subject: subject)
  end

  def reset_password(user_id, subject)
    @user = User.find(user_id)
    mail(to: @user.email, subject: subject)
  end
end
