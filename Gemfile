# frozen_string_literal: true

source "https://rubygems.org"
ruby "3.3.6"

gem "rails", "~> 7.2.2"
gem "sprockets-rails"
gem "graphiql-rails"
gem "graphql", "~> 2.2"
gem "pg", "~> 1.1"
gem "puma", ">= 5.0"
gem "importmap-rails"
gem "turbo-rails"
gem "stimulus-rails"
gem "jbuilder"
gem "bcrypt", "~> 3.1.7"
gem "tzinfo-data", platforms: %i[ windows jruby ]
gem "bootsnap", require: false
gem "figaro", "~> 1.2"

group :development, :test do
  gem "debug", platforms: %i[ mri windows ], require: "debug/prelude"
  gem "brakeman", require: false
  gem "fabrication"
  gem "faker"
  gem "rspec-rails"
  gem "simplecov"
  gem "shoulda-matchers", "~> 6.0"
end

group :development do
  gem "annotate", "~> 3.2"
  gem "rubocop-rails-omakase", require: false
  gem "rubocop-performance", require: false
  gem "rubocop-graphql", require: false
  gem "rubocop-rails", require: false
  gem "rubocop-rspec", require: false
  gem "rubocop-rspec_rails", require: false
  gem "web-console"
end

group :test do
  gem "database_cleaner"
end
