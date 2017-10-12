#!/bin/bash
: ${UCP_VERSION:=2.2.3}

echo "Downloading docker/ucp:${UCP_VERSION}"
docker pull docker/ucp:${UCP_VERSION}

for SUB_IMG in agent auth auth-store cfssl compose controller dsinfo etcd hrm metrics swarm;do
  echo "Downloading docker/ucp-${SUB_IMG}:${UCP_VERSION}"
  docker pull docker/ucp-${SUB_IMG}:${UCP_VERSION}
done
