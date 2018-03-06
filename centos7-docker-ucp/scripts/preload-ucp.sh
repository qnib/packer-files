#!/bin/bash
UCP_VERSION=${1}

if [[ "X${UCP_VERSION}" == "X" ]];then
  echo ">> Please provide UCP_VERSION as argument: ./${0} 2.2.5"
  exit 1
fi

echo "Downloading docker/ucp:${UCP_VERSION}"
docker pull docker/ucp:${UCP_VERSION}

for SUB_IMG in auth hyperkube swarm calico-cni dsinfo interlock-proxy kube-compose calico-kube-controllers etcd agent kube-dns-dnsmasq-nanny cfssl kube-dns-sidecar controller compose pause interlock-extension auth-store kube-dns metrics calico-node interlock;do
  echo "Downloading docker/ucp-${SUB_IMG}:${UCP_VERSION}"
  docker pull docker/ucp-${SUB_IMG}:${UCP_VERSION}
done
