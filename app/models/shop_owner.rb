class ShopOwner < ActiveRecord::Base
  before_create :assign_token
  has_one :shop
  has_secure_password

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true, uniqueness: true, format: {
    with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/
  }

  scope(
    :token_match,
    lambda do |id, token|
      where(id: id, activation_token: token)
    end
  )

  def assign_token
    self.active_status = false
    self.activation_token = [*"0".."9", *"a".."z", *"A".."Z"].sample(50).join
  end
end
