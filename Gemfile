source "https://rubygems.org"

gem 'rails', '5.0.0'

## Assets
gem 'sass-rails', '~> 5.0.6'
gem 'coffee-rails', '~> 4.2.2'
gem 'uglifier', '~> 4.1.14'
gem 'bootstrap-sass', '3.3.7'
gem 'font-awesome-rails', '~> 4.7.0.2'
#gem 'quiet_assets', '~> 1.1.0'

## Frontend / Views
gem 'jquery-rails', '~> 4.3.3'
gem 'redcarpet', '~> 3.4.0'
gem 'simple_form', '~> 3.5.0'
gem 'cocoon', '~> 1.2.11'
gem 'jbuilder', '~> 2.7.0'

## Backbone
gem 'ejs', '~> 1.1.1'
gem 'eco', '~> 1.0.0'

## Mongo DB
gem 'mongoid', '~> 6.0.0'
gem 'mongoid-slug', '~> 5.3.3'
gem 'geocoder', '~> 1.4.9'
gem 'mongoid_scribe', '~> 0.3.0'

## Authentication
gem 'omniauth', '~> 1.8.1'
gem 'omniauth-facebook', '~> 5.0.0'
gem 'bcrypt', '~> 3.1.12'

## Operations
gem 'passenger', '5.0.28', require: 'phusion_passenger/rack_handler'
gem 'exception_notification', '~> 4.2.2', group: [:production]
gem 'pry-rails', '~> 0.3.4'

group :development do
  gem 'capistrano-rails', '~> 1.4.0', require: false
  gem 'capistrano-passenger', '~> 0.2.0', require: false
end

group :development, :test do
  gem 'rspec-rails', '~> 3.7.2'
  gem 'factory_bot_rails', '~> 4.10.0'
  gem 'database_cleaner', '~> 1.7.0'
  gem 'byebug', '~> 10.0.2'
  gem 'faker', '~> 1.8.7'
  gem 'teaspoon-jasmine', '~> 2.3.4'
end
