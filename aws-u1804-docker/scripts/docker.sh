#!/bin/bash

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -
add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
apt-get update
rm -f /var/lib/dpkg/lock
apt-get install -y --allow-unauthenticated docker-ce
systemctl enable docker
usermod -aG docker ubuntu
