#!/bin/bash
set -x

apt-get update 
apt-get install -y squashfs-tools

mkdir -p /opt/sarus
cd /opt/sarus
wget -qO- https://github.com/eth-cscs/sarus/releases/download/1.0.1/sarus-Release.tar.gz |tar xfz - --strip-components=1
./configure_installation.sh
ln -s /opt/sarus/bin/sarus /usr/local/bin
