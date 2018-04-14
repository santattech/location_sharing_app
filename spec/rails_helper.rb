ENV["RAILS_ENV"] ||= 'test'
require File.expand_path("../../config/environment", __FILE__)
require 'rspec/rails'
require 'spec_helper'
require 'database_cleaner'
require 'devise'

# Add additional requires below this line. Rails is not loaded until this point!

Dir[Rails.root.join("spec/support/**/*.rb")].each { |f| require f }

ActiveRecord::Migration.maintain_test_schema!

RSpec.configure do |config|
  #config.fixture_path = "#{::Rails.root}/spec/fixtures"

  #config.use_transactional_fixtures = false

  config.infer_spec_type_from_file_location!

  config.include FactoryGirl::Syntax::Methods
  #config.include Capybara::DSL
  config.include Devise::Test::ControllerHelpers, type: :controller

  # include custom helpers
  #config.include RequestHelper
  #config.include ControllerHelpers, type: :controller
  config.before(:each) do
    DatabaseCleaner.strategy = if RSpec.current_example.metadata[:js]
                                 :truncation
                               else
                                 :transaction
                               end
    DatabaseCleaner.start
  end

  config.before(:suite) do
    DatabaseCleaner.clean_with(:truncation)
  end

  config.after(:each) do
    DatabaseCleaner.clean
  end
end
