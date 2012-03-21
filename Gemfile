source :rubygems

gem 'rails', '3.2.2'

group :assets do
  gem 'sass-rails'
  gem 'coffee-rails'
  gem 'uglifier'

  gem 'twitter-bootstrap-rails'#, git: "git://github.com/seyhunak/twitter-bootstrap-rails.git"
end

## Frontend / Views
gem 'jquery-rails'
gem 'redcarpet'#, '2.0.1'
gem 'simple_form'

## Mongo DB
gem "mongoid", ">= 2.3.3"
gem "bson_ext", ">= 1.3.1"
gem "mongoid_slug"#, "0.8.3"

## Omniauth
gem "omniauth"#, ">= 1.0.0"
gem "omniauth-facebook"

# To use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.0.0'

gem 'passenger'

# Deploy with Capistrano
# gem 'capistrano'


group :development, :test do
  gem "rspec-rails", ">= 2.8.1"
  gem "mongoid-rspec", ">= 1.4.4"
  gem "factory_girl_rails", ">= 1.4.0"
  gem "mocha"
  gem 'database_cleaner'
  #gem 'ruby-debug19', require: 'ruby-debug'
end
