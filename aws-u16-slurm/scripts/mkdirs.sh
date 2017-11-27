#!/bin/bash
set -x

### Source dir
mkdir -p /usr/local/src/

mkdir -p /home/ubuntu/confd/{conf.d,templates}
mkdir -p /home/ubuntu/{slurm,systemd,etc,bin,src}
mkdir -p /home/ubuntu/etc/slurm/
chown -R ubuntu: /home/ubuntu/{confd,systemd,slurm,etc,bin,src}

mkdir -p /etc/slurm/
chown -R ubuntu: /etc/slurm/
