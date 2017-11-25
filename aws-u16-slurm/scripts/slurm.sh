#!/bin/bash
set -x
lsof /var/lib/dpkg/lock
rm -f /var/lib/dpkg/lock
dpkg --configure -a

apt-get update
rm -f /var/lib/dpkg/lock
apt-get install -y slurmctld slurmd

mv /home/ubuntu/write-slurm-conf.sh /usr/local/bin/
mv /home/ubuntu/systemd/slurmconfig.service /lib/systemd/system/
rm -rf  /home/ubuntu/systemd
