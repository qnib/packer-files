#!/bin/bash
set -x

apt-get install -y openmpi-bin libopenmpi-dev gcc
mpicc -o /home/ubuntu/bin/ring /home/ubuntu/src/ring.c
