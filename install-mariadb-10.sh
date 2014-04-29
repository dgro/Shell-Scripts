#!/bin/bash

if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root"
   exit 1
fi

apt-get -y install software-properties-common
apt-key adv --recv-keys --keyserver hkp://keyserver.ubuntu.com:80 0xcbcb082a1bb943db
add-apt-repository 'deb http://mirror.netcologne.de/mariadb/repo/10.0/ubuntu trusty main'
apt-get update
apt-get -y install mariadb-server
service mysql stop
sed -i '/bind-address/s/.*/bind-address = 0.0.0.0/' /etc/mysql/my.cnf
service mysql start