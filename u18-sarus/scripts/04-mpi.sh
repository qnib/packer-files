#!/bin/bash
set -x

export URL=http://www.mpich.org/static/downloads/3.3.2/mpich-3.3.2.tar.gz
apt-get update 
apt-get install -y --no-install-recommends build-essential wget
mkdir -p /usr/local/mpich
wget -qO- ${URL} |tar xfz - -C /usr/local/mpich --strip-components=1
cd /usr/local/mpich
./configure --disable-fortran --enable-fast=all,O3 --prefix=/usr
make -j$(nproc)
make install
ldconfig
    