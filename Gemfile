source "https://rubygems.org"

gem 'rails', '4.2.7.1'

## Assets
gem 'sass-rails', '~> 5.0.6'
gem 'coffee-rails', '~> 4.2.1'
gem 'uglifier', '~> 3.0.2'
gem 'bootstrap-sass', '3.3.7'
gem 'font-awesome-rails', '~> 4.6.3.1'
gem 'quiet_assets', '~> 1.1.0'

## Frontend / Views
gem 'jquery-rails', '~> 4.2.1'
gem 'redcarpet', '~> 3.3.3'
gem 'simple_form', '~> 3.3.1'
gem 'cocoon', '~> 1.2.9'
gem 'active_model_serializers', '~> 0.8.3'

## Backbone
gem 'ejs', '~> 1.1.1'
gem 'eco', '~> 1.0.0'

## Mongo DB
gem 'mongoid', '~> 5.1.4'
gem 'mongoid-slug', '~> 5.2.0'
gem 'geocoder', '~> 1.3.7'
gem 'mongoid_scribe', '~> 0.3.0'

## Authentication
gem 'omniauth', '~> 1.3.1'
gem 'omniauth-facebook', '~> 4.0.0'
gem 'bcrypt', '~> 3.1.11'

## Operations
gem 'passenger', '5.0.28', require: 'phusion_passenger/rack_handler'
gem 'exception_notification', '~> 4.2.1', group: [:production]
gem 'pry-rails', '~> 0.3.4'

group :development do
  gem 'capistrano-rails', '~> 1.1.6', require: false
  gem 'capistrano-passenger', '~> 0.2.0', require: false
end

group :development, :test do
  gem 'rspec-rails', '~> 3.5.2'
  gem 'factory_girl_rails', '~> 4.7.0'
  gem 'database_cleaner', '~> 1.5.3'
  gem 'byebug', '~> 9.0.5'
  gem 'faker', '~> 1.6.6'
  gem 'teaspoon-jasmine', '~> 2.3.4'
end
