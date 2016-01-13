Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, ENV["facebook_app_id"], ENV["facebook_app_secret"]
  provider :twitter, ENV["twitter_api_key"], ENV["twitter_api_secret"]
  provider :google_oauth2, ENV["google_client_id"], ENV["google_client_secret"],
           scope: "profile", name: "google"
end
