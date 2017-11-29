#!/bin/bash
set -x

mkdir -p /chome/cluser
echo ">> Create user 'cluser' w/ creating home in /chome/cluser"
useradd --create-home -d /chome/cluser --password $(openssl passwd cluser) cluser
chown -R cluser: /chome/cluser
