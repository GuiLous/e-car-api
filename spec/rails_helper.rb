# frozen_string_literal: true

require 'spec_helper'
ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'

abort('The Rails environment is running in production mode!') if Rails.env.production?

require 'rspec/rails'

require 'simplecov'
SimpleCov.start 'rails'

SimpleCov.start do
  add_filter '/initializers/'
  add_filter '/config/'
  add_filter '/app/graphql/proladdore_schema.rb'
  add_filter '/spec/'

  add_group 'Models', 'app/models'
  enable_coverage :branch # Habilita cobertura de branches

  minimum_coverage 100
end

begin
  ActiveRecord::Migration.maintain_test_schema!
rescue ActiveRecord::PendingMigrationError => e
  abort e.to_s.strip
end

require 'devise'

RSpec.configure do |config|
  config.fixture_paths = [
    Rails.root.join('spec/fixtures')
  ]
  config.use_transactional_fixtures = true
  config.infer_spec_type_from_file_location!
  config.filter_rails_from_backtrace!

  config.include Devise::Test::ControllerHelpers, type: :controller
  config.include Devise::Test::IntegrationHelpers, type: :request
  config.include Devise::Test::IntegrationHelpers, type: :feature
end

require 'shoulda/matchers'
Shoulda::Matchers.configure do |config|
  config.integrate do |with|
    with.test_framework :rspec
    with.library :rails
  end
end
