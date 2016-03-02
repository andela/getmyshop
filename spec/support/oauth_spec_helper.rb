require "omniauth"
require "omniauth-facebook"
require "omniauth-twitter"
require "faker"

module OauthSpecHelper
  def credentials
    token = Faker::Number.number(6)
    { token: token, expires_at: Time.now + 1.week, secret: "mysecret" }
  end

  def twitter_setup
    OmniAuth.config.add_mock(
      :twitter,
      uid: Faker::Address.zip_code,
      nickname: Faker::Internet.user_name,
      credentials: credentials,
      user_info: {
        name: Faker::Name.name
      }
    )
  end

  def google_setup
    OmniAuth.config.add_mock(
      :google,
      uid: Faker::Address.zip_code,
      nickname: Faker::Internet.user_name,
      credentials: credentials,
      user_info: {
        name: Faker::Name.name
      }
    )
  end

  def facebook_setup
    OmniAuth.config.add_mock(
      :facebook,
      uid: Faker::Address.zip_code,
      nickname: Faker::Internet.user_name,
      info: {
        first_name: Faker::Name.first_name,
        last_name:  Faker::Name.last_name,
        email:      Faker::Internet.free_email
      },
      credentials: credentials,
      extra: {
        raw_info: { gender: "male" }
      }
    )
  end

  def setup(provider)
    case provider
    when :twitter then twitter_setup
    when :facebook then facebook_setup
    when :google then google_setup
    end
  end
end
