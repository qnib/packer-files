#!/bin/bash
apt -y update && apt-get -y upgrade
apt -y install software-properties-common
#### Install VBoxGuestAdditions
mkdir -p /mnt/cdrom/
mount /home/vagrant/VBoxGuestAdditions_*.iso /mnt/cdrom/
bash /mnt/cdrom/VBoxLinuxAdditions.run
umount /mnt/cdrom/
rm -rf /home/vagrant/VBoxGuestAdditions_*.iso /mnt/cdrom/
