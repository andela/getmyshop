class ShopOwner < ActiveRecord::Base
  has_one :shop
  has_secure_password

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true, uniqueness: true, format: {
    with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/
  }

  def generate_token
    AESCrypt.encrypt(id, "get-my-shop-pass-phrase")
  end

  def self.token_match(token)
    id = AESCrypt.decrypt(token, "get-my-shop-pass-phrase")
    ShopOwner.where(id: id).first
  end

  def activate
    self.active_status = true
  end
end
