class GooglePolicy < BasePolicy
  def email
    nil
  end

  def oauth_expires
    Time.zone.at auth_data.credentials.expires_at
  end

  def oauth_secret
    auth_data.credentials.secret
  end
end
