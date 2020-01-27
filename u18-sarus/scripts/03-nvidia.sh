#!/bin/bash
set -x

apt-get update
apt-get install -y  make gcc

mkdir /opt
cd /opt
git clone https://github.com/NVIDIA/libnvidia-container.git
cd libnvidia-container
git checkout v1.0.6
make ubuntu18.04
mkdir /usr/local/libnvidia-container_1.0.6
tar xf dist/ubuntu18.04/amd64/libnvidia-container_1.0.6_amd64.tar.xz --strip-components=3 -C /usr/

apt-get install -y golang
export GOPATH=/go
go get github.com/NVIDIA/nvidia-container-runtime
cd $GOPATH/src/github.com/NVIDIA/nvidia-container-runtime/
git checkout v3.1.4
cd $GOPATH
go build -ldflags "-s -w" -v github.com/NVIDIA/nvidia-container-runtime/toolkit/nvidia-container-toolkit
cp $GOPATH/nvidia-container-toolkit /opt/sarus/bin/nvidia-container-toolkit-3.1.4

mkdir /etc/nvidia-container-runtime/
cp /go/src/github.com/NVIDIA/nvidia-container-runtime/toolkit/config.toml.ubuntu /etc/nvidia-container-runtime/config.toml

apt install -y nvidia-utils-390 nvidia-driver-390