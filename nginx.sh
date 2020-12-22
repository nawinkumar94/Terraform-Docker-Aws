#!/bin/bash

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
apt-get update

apt-get install mysql-server
apt-get install mysql-client

apt-cache policy docker-ce
apt-get install -y docker-ce

# pull nginx image
docker pull nginx:latest

# run container with port mapping - host:container
docker run -d -p 80:80 --name nginx nginx
