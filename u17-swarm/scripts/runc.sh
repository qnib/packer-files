#!/bin/bash

echo "####### Clone runc"
apt-get update
apt-get install -y --allow-unauthenticated golang-go make git
cd /root/
git clone https://github.com/opencontainers/runc.git
cd runc
echo "####### Build runc within golang container"
make
cp runc /usr/local/bin/
