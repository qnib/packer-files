#!/bin/bash

DOCKER_VER=17.10.0
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -
add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
apt-get update
apt-get install -y --allow-unauthenticated docker-ce
wget -qO- https://github.com/qnib/docker-ce/releases/download/v${DOCKER_VER}-ce/docker-${DOCKER_VER}-ce.tar.gz |tar xfz - -C /
