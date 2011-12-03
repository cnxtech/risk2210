source 'http://rubygems.org'

gem 'rails', '3.1.3'

# Bundle edge Rails instead:
# gem 'rails',     :git => 'git://github.com/rails/rails.git'



# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 3.1.5'
  gem 'coffee-rails', '~> 3.1.1'
  gem 'uglifier', '>= 1.0.3'
end

gem 'jquery-rails'
gem 'twitter-bootstrap-rails'

## Mongo DB
gem "mongoid", ">= 2.3.3"
gem "bson_ext", ">= 1.3.1"

## Omniauth
gem "omniauth", ">= 1.0.0"
gem "omniauth-facebook"

# To use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.0.0'

gem 'passenger'

# Deploy with Capistrano
# gem 'capistrano'

# To use debugger
# gem 'ruby-debug19', :require => 'ruby-debug'

group :development, :test do
  gem "rspec-rails", ">= 2.8.0.rc1", :group => [:development, :test]
  gem "mongoid-rspec", ">= 1.4.4"
  gem "factory_girl_rails", ">= 1.4.0", :group => :test
  gem "mocha"
  gem 'database_cleaner'
end
