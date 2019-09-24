#!/bin/bash
set -x

wget -qO /usr/bin/confd https://github.com/kelseyhightower/confd/releases/download/v0.14.0/confd-0.14.0-linux-amd64
chmod +x /usr/bin/confd

mkdir -p /etc/confd/{conf.d,templates}
rsync -aP /home/ubuntu/confd/. /etc/confd/.
rm -rf /home/ubuntu/confd
