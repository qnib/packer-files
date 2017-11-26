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
systemctl enable slurmconfig
rm -rf  /home/ubuntu/systemd
mv /home/ubuntu/munge.key /etc/munge/
chown munge: /etc/munge/munge.key
chmod 400 /etc/munge/munge.key
