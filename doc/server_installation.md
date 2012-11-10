## Server Installation Instructions

### Install Ruby
curl -L https://raw.github.com/nick-desteffen/ruby-bootstrap/master/bootstrap_ruby_193.sh | sudo bash

### Install MongoDB
curl -L https://raw.github.com/nick-desteffen/mongodb-bootstrap/master/bootstrap_mongodb.sh | sudo bash

### Install Git
sudo apt-get install -y git

### Install Passenger & Nginx
sudo gem install passenger<br>
sudo passenger-install-nginx-module<br>
cd /etc/init.d<br>
sudo wget https://raw.github.com/nick-desteffen/nginx-init-ubuntu-passenger/master/nginx<br>
sudo update-rc.d nginx defaults<br>
sudo chmod +x nginx<br>
sudo /etc/init.d/nginx start<br>
sudo mkdir -p /var/www/apps<br>
sudo chmod 755 -R /var/www/apps<br>
