require "simplecov"
SimpleCov.start
require "coveralls"
Coveralls.wear!
require "factory_girl_rails"
require "support/form_helpers"
require "support/login_helper"
require "capybara"
require "omniauth"
require "support/database_cleaner"

RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.include FactoryGirl::Syntax::Methods
  config.include FormHelpers, type: :feature
  config.include LoginHelper, type: :controller
end

OmniAuth.config.test_mode = true
