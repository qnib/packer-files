#!/bin/bash -eux

cat >> /etc/hosts << EOF
192.168.56.10 headnode
192.168.56.11 compute1
192.168.56.12 compute2
192.168.56.13 compute3
192.168.56.14 compute4
EOF