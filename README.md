# Risk 2210 Website

## Installation Instructions

### Install git
[http://git-scm.com/](http://git-scm.com/)

### Install MongoDB
[http://www.mongodb.org](http://www.mongodb.org/)

### Install RVM
[http://beginrescueend.com/](http://beginrescueend.com/)

### Create Gemset
```rvm gemset create risk2210```

### Install Bundler
```gem install bundler```

### Install project gems
```bundle install```

### Seed database
```bundle exec rake db:seed```

### Run passenger
```bundle exec passenger start```