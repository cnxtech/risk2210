source "https://rubygems.org"

gem 'rails', '4.2.10'

## Assets
gem 'sass-rails', '~> 5.0.6'
gem 'coffee-rails', '~> 4.2.2'
gem 'uglifier', '~> 4.0.2'
gem 'bootstrap-sass', '3.3.7'
gem 'font-awesome-rails', '~> 4.7.0.2'
gem 'quiet_assets', '~> 1.1.0'

## Frontend / Views
gem 'jquery-rails', '~> 4.3.1'
gem 'redcarpet', '~> 3.4.0'
gem 'simple_form', '~> 3.5.0'
gem 'cocoon', '~> 1.2.11'
gem 'active_model_serializers', '~> 0.8.4'

## Backbone
gem 'ejs', '~> 1.1.1'
gem 'eco', '~> 1.0.0'

## Mongo DB
gem 'mongoid', '~> 5.1.4'
gem 'mongoid-slug', '~> 5.2.0'
gem 'geocoder', '~> 1.4.5'
gem 'mongoid_scribe', '~> 0.3.0'

## Authentication
gem 'omniauth', '~> 1.3.2'
gem 'omniauth-facebook', '~> 4.0.0'
gem 'bcrypt', '~> 3.1.11'

## Operations
gem 'passenger', '5.0.28', require: 'phusion_passenger/rack_handler'
gem 'exception_notification', '~> 4.2.2', group: [:production]
gem 'pry-rails', '~> 0.3.4'

group :development do
  gem 'capistrano-rails', '~> 1.3.1', require: false
  gem 'capistrano-passenger', '~> 0.2.0', require: false
end

group :development, :test do
  gem 'rspec-rails', '~> 3.7.2'
  gem 'factory_girl_rails', '~> 4.7.0'
  gem 'database_cleaner', '~> 1.6.2'
  gem 'byebug', '~> 9.1.0'
  gem 'faker', '~> 1.8.5'
  gem 'teaspoon-jasmine', '~> 2.3.4'
end
