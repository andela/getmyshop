class TwitterPolicy < BasePolicy
  def email
    nil
  end

  def oauth_expires
    nil
  end

  def oauth_secret
    auth_data.credentials.secret
  end
end
