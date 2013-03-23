# Server Installation Instructions

### Install Ruby
`curl -L https://raw.github.com/nick-desteffen/ruby-bootstrap/master/bootstrap_ruby_193.sh | sudo bash`

### Install MongoDB
`curl -L https://raw.github.com/nick-desteffen/mongodb-bootstrap/master/bootstrap_mongodb.sh | sudo bash`

### Install Git
`sudo apt-get install -y git`

### Install Passenger & Nginx
`sudo gem install passenger`  
`sudo passenger-install-nginx-module`  
`cd /etc/init.d`  
`sudo wget https://raw.github.com/nick-desteffen/nginx-init-ubuntu-passenger/master/nginx`  
`sudo update-rc.d nginx defaults`  
`sudo chmod +x nginx`   
`sudo /etc/init.d/nginx start`  
`sudo mkdir -p /var/www/apps`  
`sudo chmod 755 -R /var/www/apps`  
