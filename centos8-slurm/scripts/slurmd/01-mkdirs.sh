#!/bin/bash -eux

mkdir -p /home/vagrant/{etc/slurm/,usr/lib/systemd/system,usr/local/bin}
chown -R vagrant: /home/vagrant/{etc,usr}