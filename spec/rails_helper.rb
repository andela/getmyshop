ENV["RAILS_ENV"] ||= "test"
require File.expand_path("../../config/environment", __FILE__)

abort("The Rails environment is running in production mode!") if
  Rails.env.production?
require "spec_helper"
require "rspec/rails"
require "capybara/rspec"
require "capybara/rails"
require "database_cleaner"
require "transactional_capybara/rspec"

ActiveRecord::Migration.maintain_test_schema!

RSpec.configure do |config|
  config.fixture_path = "#{::Rails.root}/spec/fixtures"
  config.use_transactional_fixtures = false
  config.infer_spec_type_from_file_location!

  config.filter_rails_from_backtrace!
  config.include FactoryGirl::Syntax::Methods

  config.before(:suite) do
    DatabaseCleaner.clean_with(:truncation)
    DatabaseCleaner.strategy = :transaction
    begin
      FactoryGirl.lint
      DatabaseCleaner.clean_with(:truncation)
    rescue
      DatabaseCleaner.clean_with(:truncation)
    end
  end

  config.after(:each, js: true) do
    TransactionalCapybara::AjaxHelpers.wait_for_ajax(page)
  end

  config.before(:each) do
    DatabaseCleaner.start
  end

  config.after(:each) do
    DatabaseCleaner.clean
  end
end

Shoulda::Matchers.configure do |config|
  config.integrate do |with|
    with.test_framework :rspec
    with.library :rails
  end
end
