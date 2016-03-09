require "simplecov"
SimpleCov.start
require "factory_girl_rails"
require "support/form_helpers"
require "omniauth"

RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.include FactoryGirl::Syntax::Methods

  config.include FormHelpers, type: :feature
end
OmniAuth.config.test_mode = true
