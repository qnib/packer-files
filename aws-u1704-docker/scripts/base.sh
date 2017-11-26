#!/bin/bash
set -x
lsof /var/lib/dpkg/lock
rm -f /var/lib/dpkg/lock
dpkg --configure -a

sleep 5

apt-get update
rm -f /var/lib/dpkg/lock
apt-get install -y curl
