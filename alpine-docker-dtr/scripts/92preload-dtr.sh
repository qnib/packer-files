#!/bin/bash
: ${DTRVERSION:=2.3.3}
echo "Downloading docker/dtr:${DTRVERSION}"
docker pull docker/dtr:${DTRVERSION}

for SUB_IMG in api garant jobrunner nginx notary-server notary-signer postgres registry rethink;do
  echo "Downloading docker/dtr-${SUB_IMG}:${DTRVERSION}"
  docker pull docker/dtr-${SUB_IMG}:${DTRVERSION}
done
