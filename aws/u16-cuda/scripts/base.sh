#!/bin/bash
set -x

lsof /var/lib/dpkg/lock
rm -f /var/lib/dpkg/lock
dpkg --configure -a
apt-get update
rm -f /var/lib/dpkg/lock
