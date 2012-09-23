# Risk 2210 Website

## Server Installation Instructions

### Ruby
curl -L https://raw.github.com/nick-desteffen/ruby-bootstrap/master/bootstrap_ruby_193.sh | sudo bash

### MongoDB
curl -L https://raw.github.com/nick-desteffen/mongodb-bootstrap/master/bootstrap_mongodb.sh | sudo bash

### Git
sudo apt-get install -y git

### Passenger & Nginx
sudo gem install passenger  
sudo passenger-install-nginx-module  
cd /etc/init.d  
sudo wget https://raw.github.com/nick-desteffen/nginx-init-ubuntu-passenger/master/nginx  
sudo update-rc.d nginx defaults  
sudo chmod +x nginx  
sudo /etc/init.d/nginx start  

sudo mkdir -p /var/www/apps  
sudo chmod 755 -R /var/www/apps  

### Create User
sudo useradd -m -s /bin/bash nickd  
sudo passwd nickd  
sudo vi /etc/sudoers  
  -- Add entry  

Login as nickd && copy id_rsa.pub to ~/.ssh/authorized_keys

### Disable SSH password authentication
sudo vi /etc/sshd_config  
  -- Disable password