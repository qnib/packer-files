#!/bin/bash
set -x
lsof /var/lib/dpkg/lock
rm -f /var/lib/dpkg/lock
dpkg --configure -a

sleep 5

export DEBIAN_FRONTEND=noninteractive
apt-get update
apt-get upgrade -y
rm -f /var/lib/dpkg/lock
apt-get install -y curl wget
