#!/bin/bash

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
apt-get update

# install docker community edition
apt-cache policy docker-ce
apt-get install -y docker-ce

docker pull mysql:latest

docker run --name mysql -p 3306:3306 -e MYSQL_ROOT_PASSWORD=password -e MYSQL_USER=dbuser -e MYSQL_PASSWORD=password -d mysql
