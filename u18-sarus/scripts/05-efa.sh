#!/bin/bash
set -x

mkdir -p /opt/aws-efa-installer
cd /opt/aws-efa-installer
curl -O https://s3-us-west-2.amazonaws.com/aws-efa-installer/aws-efa-installer-1.7.0.tar.gz
tar xfz aws-efa-installer-1.7.0.tar.gz --strip-components=1
./efa_installer.sh -y --skip-kmod --no-verify
cd /root/
rm -rf /opt/aws-efa-installer