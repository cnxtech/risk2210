source :rubygems

gem 'rails', '3.2.11'
gem 'strong_parameters'

group :assets do
  gem 'sass-rails'
  gem 'coffee-rails'
  gem 'uglifier'
  gem 'twitter-bootstrap-rails'#, git: "git@github.com:seyhunak/twitter-bootstrap-rails.git"
  gem 'less-rails'
  gem 'therubyracer'
end

## Frontend / Views
gem 'jquery-rails'
gem 'redcarpet'
gem 'simple_form'
gem 'cocoon'
gem 'active_model_serializers'

## Backbone
gem "ejs"
gem "eco"

## Mongo DB
gem "mongoid", ">= 3.0.0"
gem "mongoid_slug"

## Authentication
gem "omniauth"#, ">= 1.0.0"
gem "omniauth-facebook"
gem 'bcrypt-ruby'#, '~> 3.0.0'

## Operations
gem 'passenger'
gem 'exception_notification'
gem 'hashie'

group :development do
  gem 'capistrano', require: false
  gem 'capistrano-helpers', require: false
end

group :development, :test do
  gem "rspec-rails", ">= 2.8.1"
  gem "factory_girl_rails", ">= 1.4.0"
  gem 'database_cleaner'
  gem 'debugger'
  gem "ffaker"
  gem "jasminerice", git: "git@github.com:nick-desteffen/jasminerice.git"
end
