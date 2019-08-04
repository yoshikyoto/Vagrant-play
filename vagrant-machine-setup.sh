#!/usr/bin/env bash

#variables
activatorVersion="1.3.10"
sbtVersion="0.13.11"

echo "=========================================="
echo "Provision VM START"
echo "=========================================="

# -y は Y/n の選択肢を表示せず Y を選ぶ
# -q は経過ログを出力しない
sudo apt-get -y -q update
sudo apt-get -y -q upgrade
sudo apt-get -y -q install software-properties-common htop
sudo apt-get -y -q install build-essential
sudo apt-get -y -q install tcl8.5

###############################################
# Install Java 8
###############################################
# sudo add-apt-repository ppa:openjdk-r/ppa -y
# sudo apt-get update
# sudo apt-get install openjdk-8-jdk -y

###############################################
# Install Git
###############################################
sudo apt-get -y install git

###############################################
# Install imagemagick
###############################################
sudo apt-get -y install imagemagick

###############################################
# Install Scala
###############################################
# sudo apt-get -y install scala

###############################################
# Install Unzip
###############################################
sudo apt-get -y install unzip

###############################################
# Install NodeJS
###############################################
curl --silent --location https://deb.nodesource.com/setup_12.x | sudo bash -
sudo apt-get -y install nodejs
ln -s /usr/bin/nodejs /user/bin/node
# Add node_modules to environment variables
echo "export NODE_PATH=/usr/local/lib/node_modules" >> ~/.bashrc

###############################################
# Install NPM
###############################################
sudo apt-get -y install npm

###############################################
# Install Sass
###############################################
# sudo gem install sass

###############################################
# Install Redis
# More info about it: https://www.digitalocean.com/community/tutorials/how-to-install-and-use-redis
###############################################
# echo "Download Redis..."
# wget http://download.redis.io/releases/redis-stable.tar.gz
# tar xzf redis-stable.tar.gz
# cd redis-stable
# make
# make test
# sudo make install
# cd utils
# sudo ./install_server.sh
# cd /home/vagrant/
# rm redis-stable.tar.gz
# echo "Redis done."

###############################################
# Install PostgreSQL
###############################################
sudo apt-get -y install postgresql postgresql-contrib postgresql-client-common postgresql-common

###############################################
# Install SBT
###############################################
echo "Download SBT..."
wget http://dl.bintray.com/sbt/debian/sbt-$sbtVersion.deb
sudo dpkg -i sbt-$sbtVersion.deb
sudo apt-get update
sudo apt-get install sbt
rm sbt-$sbtVersion.deb

echo "SBT done."
# Use node as default JavaScript Engine
echo "export SBT_OPTS=\"\$SBT_OPTS -Dsbt.jse.engineType=Node\"" >> ~/.bashrc

###############################################
# Install typesafe activator
###############################################
cd /home/vagrant
echo "Download Typesafe Activator..."
wget http://downloads.typesafe.com/typesafe-activator/$activatorVersion/typesafe-activator-$activatorVersion.zip
unzip -d /home/vagrant typesafe-activator-$activatorVersion.zip
rm typesafe-activator-$activatorVersion.zip
echo "Typesafe Activator done."
# Add activator to environment variables
echo "export PATH=/home/vagrant/activator-dist-$activatorVersion/bin:\$PATH" >> ~/.bashrc

###############################################
# Reset bash
###############################################
source ~/.bashrc

###############################################
# Show installation summary
###############################################
echo "=========================================="
echo "Provision VM summary"
echo "=========================================="
echo "Dependencies installed:"
echo " "
echo "jdk version:"
javac -version
echo " "
echo "NodeJS version:"
node -v
echo " "
echo "NPM version"
npm -v
echo " "
echo "PostgreSQL version"
psql --version
echo " "
echo "=========================================="
echo "Provision VM finished"
echo "=========================================="
