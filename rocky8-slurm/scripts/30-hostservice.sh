#!/bin/bash


cp /home/vagrant/usr/local/bin/adjust-hosts.sh /usr/local/bin/adjust-hosts.sh
chmod +x /usr/local/bin/adjust-hosts.sh
cp /home/vagrant/usr/lib/systemd/system/hostfile.service /lib/systemd/system/hostfile.service
systemctl enable hostfile