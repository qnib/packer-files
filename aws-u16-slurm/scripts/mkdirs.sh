#!/bin/bash
set -x

mkdir -p /home/ubuntu/confd/{conf.d,templates}
mkdir -p /home/ubuntu/systemd/
chown -R ubuntu: /home/ubuntu/confd /home/ubuntu/systemd
