class User < ActiveRecord::Base
  has_many :oauth_accounts
  has_many :orders
  has_many :addresses, dependent: :destroy

  before_create :assign_token

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

  def list_addresses
    self.addresses.where(archived_at: nil)
  end
end
