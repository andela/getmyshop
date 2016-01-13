class OauthUser
  attr_reader :auth_data, :provider, :policy, :user

  def initialize(auth_data)
    @auth_data = auth_data
    @provider = auth_data.provider
    @user = nil
    @policy = "#{@provider.capitalize}Policy".constantize.new(auth_data)
  end

  def login_or_create
    create_new_account unless login_successful?

    user
  end

  def login_successful?
    account = OauthAccount.
              where(provider: policy.provider, uid: policy.uid).
              first
    if account.present?
      @user = account.user
      refresh_tokens account

      true
    else
      false
    end
  end

  def refresh_tokens(account)
    account.update_attributes(
      oauth_secret: policy.oauth_secret,
      oauth_token: policy.oauth_token,
      oauth_expires: policy.oauth_expires
    )
  end

  def create_new_account
    @user = User.create(user_params)
    if user
      OauthAccount.create account_params
    end
  end

  private

  def account_params
    {
      provider: provider,
      uid: policy.uid,
      oauth_secret: policy.oauth_secret,
      oauth_token: policy.oauth_token,
      oauth_expires: policy.oauth_expires,
      user_id: user.id
    }
  end

  def user_params
    {
      first_name: policy.first_name,
      last_name: policy.last_name,
      email: policy.email,
      active_status: true
    }
  end
end
