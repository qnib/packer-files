#!/bin/bash -eux

DOCKER_VER=17.10.0

yum install -y yum-utils \
  device-mapper-persistent-data \
  lvm2

yum-config-manager \
    --add-repo \
    https://download.docker.com/linux/centos/docker-ce.repo
yum install -y docker-ce
#wget -qO- https://github.com/qnib/docker-ce/releases/download/v${DOCKER_VER}-ce/docker-${DOCKER_VER}-ce.tar.gz |tar xfz - -C /
systemctl enable docker
mkdir -p /etc/docker/
