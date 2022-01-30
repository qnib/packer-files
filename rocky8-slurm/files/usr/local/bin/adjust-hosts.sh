#!/bin/bash


echo ">> Add fixed set of hosts to /etc/hosts"
echo "" >> /etc/hosts
echo "## Fixed list of hosts to allow slurm-cluster to form" >> /etc/hosts
cat >> /etc/hosts << EOF
192.168.56.10 headnode
192.168.56.11 compute1
192.168.56.12 compute2
192.168.56.13 compute3
192.168.56.14 compute4
EOF
