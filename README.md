# Risk 2210 Website
[![Code Climate](https://codeclimate.com/github/nick-desteffen/risk2210.png)](https://codeclimate.com/github/nick-desteffen/risk2210)

I built this website as a way to learn [Backbone.js](http://backbonejs.org) and [MongoDB](http://www.mongodb.org/).  You can check it out at [https://risk2210.net](https://risk2210.net).
It was built using the following frameworks & libraries:

 * [Ruby on Rails](http://rubyonrails.org)
 * [Mongoid](http://mongoid.org)
 * [Backbone.js](http://backbonejs.org)
 * [Twitter Bootstrap](http://twitter.github.io/bootstrap/)
 * [NVD3](http://nvd3.org)
 * [RSpec](http://rspec.info/)

## Dependencies

 * [MongoDB](http://www.mongodb.org) >= 2.2.0
 * [Ruby](http://www.ruby-lang.org/en/) >= 2.0.0

## MongoDB Installation
#### Ubuntu
I've got a script to install MongoDB on Ubuntu, just follow the instructions on the repo:  
[https://github.com/nick-desteffen/mongodb-bootstrap](https://github.com/nick-desteffen/mongodb-bootstrap)

#### OSX
Use [HomeBrew](http://mxcl.github.com/homebrew/)

## Ruby Installation
#### Ubuntu
I've got a script to install Ruby 2.0.0 on Ubuntu, just follow the instructions on the repo:  
[https://github.com/nick-desteffen/ruby-bootstrap](https://github.com/nick-desteffen/ruby-bootstrap)

#### OSX
Use [RVM](http://rvm.io) or [rbenv](https://github.com/sstephenson/rbenv/)

## Project Setup
#### settings.yml
Copy the **config/settings.yml.example** file to **config/settings.yml** and update it to include your own email config, Facebook auth, exception notifier, and secret token values.

#### Database
Seed it:  
`bundle exec rake db:seed`

## Starting

Run: `bundle exec passenger start`  
Visit: [http://localhost:3000](lhttp://localhost:3000)

## Running Tests
Ruby: `bundle exec rake spec`  
  
Javascript: `bundle exec teaspoon`