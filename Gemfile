source 'https://nexus.vinted.net/repository/rubygems-proxy-repos-group/'
private_gem_source = 'https://nexus.vinted.net/repository/rubygems-cloudsmith-repos-group/'

gem 'interactor-initializer' # to be used for writing interactors
gem 'active_model_serializers' # for object serialization

group :development, :test do
  gem 'rspec'
  gem 'rspec-rails' # we skipped default testing framework for Rails and are using RSpec instead
  gem 'factory_bot_rails' # for creating spec fixtures
end

group :development do
  gem 'rubocop', require: false
  gem 'vinted-rubocop', require: false, source: private_gem_source
end

# Bundle edge Rails instead: gem "rails", github: "rails/rails", branch: "main"
gem "rails", "~> 8.0.2"
# Use mysql as the database for Active Record
gem "mysql2", "~> 0.5"
# Use the Puma web server [https://github.com/puma/puma]
gem "puma", ">= 5.0"
gem 'sidekiq', '~> 8.0'
gem 'sidekiq-cron'


# Build JSON APIs with ease [https://github.com/rails/jbuilder]
# gem "jbuilder"

# Use Active Model has_secure_password [https://guides.rubyonrails.org/active_model_basics.html#securepassword]
# gem "bcrypt", "~> 3.1.7"

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem "tzinfo-data", platforms: %i[ windows jruby ]

# Reduces boot times through caching; required in config/boot.rb
gem "bootsnap", require: false

# Add HTTP asset caching/compression and X-Sendfile acceleration to Puma [https://github.com/basecamp/thruster/]
gem "thruster", require: false

gem 'kaminari'


# Use Rack CORS for handling Cross-Origin Resource Sharing (CORS), making cross-origin Ajax possible
# gem "rack-cors"

