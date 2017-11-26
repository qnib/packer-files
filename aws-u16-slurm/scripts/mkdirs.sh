#!/bin/bash
set -x

mkdir -p /home/ubuntu/confd/{conf.d,templates}
mkdir -p /home/ubuntu/{slurm,systemd,etc,bin,src}
chown -R ubuntu: /home/ubuntu/{confd,systemd,slurm,etc,bin,src}
