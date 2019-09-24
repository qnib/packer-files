#!/bin/bash

curl -fsSL "${1}/ubuntu/gpg" | apt-key add -
add-apt-repository "deb [arch=amd64] $1/ubuntu $(lsb_release -cs) stable"
apt-get update
rm -f /var/lib/dpkg/lock
apt-get install -y docker-ee
