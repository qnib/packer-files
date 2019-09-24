#!/bin/bash
set -x

apt-get install -y nfs-common
mv /home/ubuntu/systemd/nfsclient.service /lib/systemd/system/
mv /home/ubuntu/configure-nfs-client.sh /usr/local/bin/
systemctl enable nfsclient
