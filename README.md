# Risk 2210 Website
I built this website as a way to learn [Backbone.js](http://backbonejs.org) and [MongoDB](http://www.mongodb.org/) It uses the following frameworks & libraries:

 * Ruby on Rails
 * Mongoid
 * Backbone.js
 * Twitter Bootstrap
 * NVD3

## Dependencies

 * MongoDB >= 2.2.0
 * Ruby >= 1.9.3

## MongoDB Installation
#### Ubuntu
I've got a script to install MongoDB on Ubuntu, just follow the instructions on the repo:  
[https://github.com/nick-desteffen/mongodb-bootstrap](https://github.com/nick-desteffen/mongodb-bootstrap)

#### OSX
Use [HomeBrew](http://mxcl.github.com/homebrew/)  

## Ruby Installation
#### Ubuntu
I've got a script to install Ruby 1.9.3 or Ruby 2.0.0 on Ubuntu, just follow the instructions on the repo:  
[https://github.com/nick-desteffen/ruby-bootstrap](https://github.com/nick-desteffen/ruby-bootstrap)

#### OSX
Use [RVM](http://rvm.io) or [rbenv](https://github.com/sstephenson/rbenv/)

## Project Setup
To get the project up and running just copy the **config/settings.yml.example** to **config/settings.yml** and update it to include your own email, Facebook Auth, and Secret token values.

## Starting

Run: `bundle exec passenger start`  
Visit: [http://localhost:3000](lhttp://localhost:3000)