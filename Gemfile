source :rubygems

gem 'rails', '3.1.3'

group :assets do
  gem 'sass-rails',   '~> 3.1.5'
  gem 'coffee-rails', '~> 3.1.1'
  gem 'uglifier', '>= 1.0.3'
end

## Frontend / Views
gem 'jquery-rails'
gem 'twitter-bootstrap-rails'
gem 'redcarpet', '2.0.1'

## Mongo DB
gem "mongoid", ">= 2.3.3"
gem "bson_ext", ">= 1.3.1"
gem "mongoid_slug", "0.8.3"

## Omniauth
gem "omniauth", ">= 1.0.0"
gem "omniauth-facebook"

# To use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.0.0'

gem 'passenger'

# Deploy with Capistrano
# gem 'capistrano'


group :development, :test do
  gem "rspec-rails", ">= 2.8.0.rc1"
  gem "mongoid-rspec", ">= 1.4.4"
  gem "factory_girl_rails", ">= 1.4.0"
  gem "mocha"
  gem 'database_cleaner'
  gem 'ruby-debug19', require: 'ruby-debug'
end
