#!/bin/bash
set -x

: "${DEV_CUDA_URL:=https://developer.nvidia.com/compute/cuda}"
: "${CUDA_REPO_DEB:=cuda-repo-ubuntu1604-8-0-local-ga2_8.0.61-1_amd64-deb}"
: "${CUBLAS_REPO_DEB:=cuda-repo-ubuntu1604-8-0-local-cublas-performance-update_8.0.61-1_amd64-deb}"

cd /tmp/
wget -q "${DEV_CUDA_URL}/8.0/Prod2/local_installers/${CUDA_REPO_DEB}"
dpkg -i ${CUDA_REPO_DEB}
rm -f ${CUDA_REPO_DEB}
wget -q "${DEV_CUDA_URL}/8.0/Prod2/patches/2/${CUBLAS_REPO_DEB}"
dpkg -i ${CUBLAS_REPO_DEB}
apt-get update
apt-get install -y cuda
mkdir -p /usr/local/cuda-8.0/
wget -qO - http://developer.download.nvidia.com/compute/redist/cudnn/v6.0/cudnn-8.0-linux-x64-v6.0.tgz |tar xfz - -C /usr/local/cuda-8.0/ --strip-components=1
