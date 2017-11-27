#!/bin/bash
set -xeo pipefail

rm -f /var/lib/dpkg/lock
apt-get install -y gcc

## openmpi
wget -qO - https://www.open-mpi.org/software/ompi/v3.0/downloads/openmpi-3.0.0.tar.bz2|tar xfj - -C /usr/local/src/
cd /usr/local/src/openmpi-3.0.0
./configure --prefix=/usr/ --with-pmi --with-slurm
make -j4
make install

mpicc -o /home/ubuntu/bin/ring /home/ubuntu/src/ring.c
