#!/usr/bin/env bash
# update / upgrade
DEFAULTPASS="root"
sudo apt-get update
sudo apt-get -y upgrade

# install apache 2.5 and php 5.5
sudo apt-get install -y apache2
sudo apt-get install -y php5

# install mysql and give password to installer
sudo debconf-set-selections <<< "mysql-server mysql-server/root_password password $DEFAULTPASS"
sudo debconf-set-selections <<< "mysql-server mysql-server/root_password_again password $DEFAULTPASS"
sudo apt-get -y install mysql-server
sudo apt-get install php5-mysql

# install phpmyadmin and give password(s) to installer
# for simplicity I'm using the same password for mysql and phpmyadmin
sudo debconf-set-selections <<< "phpmyadmin phpmyadmin/dbconfig-install boolean true"
sudo debconf-set-selections <<< "phpmyadmin phpmyadmin/app-password-confirm password $DEFAULTPASS"
sudo debconf-set-selections <<< "phpmyadmin phpmyadmin/mysql/admin-pass password $DEFAULTPASS"
sudo debconf-set-selections <<< "phpmyadmin phpmyadmin/mysql/app-pass password $DEFAULTPASS"
sudo debconf-set-selections <<< "phpmyadmin phpmyadmin/reconfigure-webserver multiselect apache2"
sudo apt-get -y install phpmyadmin


# install git
sudo apt-get -y install git-core

install Composer
curl -s https://getcomposer.org/installer | php
mv composer.phar /usr/local/bin/composer
