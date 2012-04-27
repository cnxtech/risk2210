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