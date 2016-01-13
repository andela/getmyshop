class BasePolicy
  attr_reader :auth_data

  def initialize(auth_data)
    @auth_data = auth_data
  end

  def first_name
    name[:first_name]
  end

  def last_name
    name[:last_name]
  end

  delegate :provider, :uid, to: :auth_data

  def oauth_token
    auth_data.credentials.token
  end

  private

  def name
    full_name = auth_data.info.name
    split_names = full_name.split(" ")
    {
      first_name: split_names[0],
      last_name: split_names[1..-1].join(" ")
    }
  end
end
