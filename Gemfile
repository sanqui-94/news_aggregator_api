source "https://rubygems.org"

ruby "3.4.8"

gem "rails", "~> 8.1.2"
gem "pg", "~> 1.1"
gem "puma", ">= 5.0"
gem "bootsnap", require: false
gem "tzinfo-data", platforms: %i[ windows jruby ]

gem "rack-cors"

gem "sidekiq"
gem "sidekiq-scheduler"


gem "devise"
gem "omniauth-google-oauth2"
gem "omniauth-github"
gem "omniauth-rails_csrf_protection"

gem "graphql"

gem "pundit"


gem "aasm"
gem "pg_search"
gem "feedjira"


gem "dotenv-rails"

gem "solid_cache"

gem "kamal", require: false
gem "thruster", require: false

group :development, :test do
  gem "debug", platforms: %i[ mri windows ], require: "debug/prelude"
  gem "rspec-rails"
  gem "factory_bot_rails"
  gem "shoulda-matchers"
  gem "bundler-audit", require: false
  gem "brakeman", require: false
  gem "rubocop-rails-omakase", require: false
end


group :development do
  gem "bullet" # N+1 query detection
end
