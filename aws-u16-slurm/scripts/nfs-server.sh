#!/bin/bash
set -x

apt-get install -y nfs-kernel-server
systemctl disable nfs-server

mv /home/ubuntu/systemd/nfsserver.service /lib/systemd/system/
mv /home/ubuntu/configure-nfs-server.sh /usr/local/bin/
systemctl enable nfsserver
