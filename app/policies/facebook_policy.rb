class FacebookPolicy < BasePolicy
  def email
    auth_data.info.email
  end

  def oauth_expires
    Time.zone.at auth_data.credentials.expires_at
  end

  def oauth_secret
    nil
  end
end
