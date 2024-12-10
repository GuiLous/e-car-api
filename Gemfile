# frozen_string_literal: true

source "https://rubygems.org"
ruby "3.3.6"

gem "bcrypt", "~> 3.1.7"
gem "bootsnap", require: false
gem "devise"
gem "devise-jwt"
gem "fabrication"
gem "faker"
gem "figaro", "~> 1.2"
gem "graphiql-rails"
gem "graphql", "~> 2.2"
gem "importmap-rails"
gem "jbuilder"
gem "pg", "~> 1.1"
gem "puma", ">= 5.0"
gem "rack-cors"
gem "rails", "~> 7.2.2"
gem "redis"
gem "sidekiq"
gem "sidekiq-scheduler"
gem "sprockets-rails"
gem "stimulus-rails"
gem "turbo-rails"
gem "tzinfo-data", platforms: %i[windows jruby]
gem 'agora_dynamic_key'

group :development, :test do
  gem "brakeman", require: false
  gem "debug", platforms: %i[mri windows], require: "debug/prelude"
  gem "rails-controller-testing"
  gem "rspec-rails"
  gem "shoulda-matchers", "~> 6.0"
  gem "simplecov"
end

group :development do
  gem "annotate", "~> 3.2"
  gem "rubocop-graphql", require: false
  gem "rubocop-performance", require: false
  gem "rubocop-rails", require: false
  gem "rubocop-rails-omakase", require: false
  gem "rubocop-rspec", require: false
  gem "rubocop-rspec_rails", require: false
  gem "web-console"
end

group :test do
  gem "database_cleaner"
end
