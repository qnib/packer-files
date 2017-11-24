#!/bin/bash
set -x

cd /tmp/
wget -q http://us.download.nvidia.com/tesla/384.81/nvidia-diag-driver-local-repo-ubuntu1604-384.81_1.0-1_amd64.deb
dpkg -i nvidia-diag-driver-local-repo-ubuntu1604-384.81_1.0-1_amd64.deb
apt-key add /var/nvidia-diag-driver-local-repo-384.81/7fa2af80.pub
apt-get update
apt-get install -y -qq cuda-drivers
