sudo apt-get -y update
sudo apt-get -y install build-essential zlib1g-dev libssl-dev libreadline-gplv2-dev libyaml-dev
mkdir ~/src
cd ~/src
wget ftp://ftp.ruby-lang.org/pub/ruby/1.9/ruby-1.9.3-p194.tar.gz
tar -xvzf ruby-1.9.3-p194.tar.gz
cd ruby-1.9.3-p194/
./configure --prefix=/usr/local
make
sudo make install
sudo gem install chef ruby-shadow --no-ri --no-rdoc

sudo mkdir /var/chef
cd /var/chef
sudo mkdir -p cookbooks/main/recipes
sudo chown -R ubuntu.ubuntu /var/chef


rsync -r . ubuntu@risk2210.net:/var/chef
ssh ubuntu@risk2210.net "sudo chef-solo -c /var/chef/solo.rb"