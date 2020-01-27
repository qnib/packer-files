#!/bin/bash

mkdir -p /etc/confd/{conf.d,templates}
wget -qO /usr/bin/confd https://github.com/kelseyhightower/confd/releases/download/v0.16.0/confd-0.16.0-linux-amd64
chmod +x /usr/bin/confd