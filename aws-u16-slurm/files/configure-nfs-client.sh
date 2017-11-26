#!/bin/bash
PHOST=master0

CNT=60
while [[ ! -f /opt/slurm-type ]];do
    sleep 1
    CNT=$((${CNT}-1))
    if [[ $CNT -eq 0 ]];then
      echo " Limit reached! NOK!"
      break
    fi
done

if [[ $(cat /opt/slurm-type) != "client" ]];then
  echo ">> I am '$(cat /opt/slurm-type)' NOT the client -> exit 0"
  exit 0
fi

set -x

echo ">> Create user 'cluser' w/o creating home in /chome/cluser"
useradd --no-create-home -d /chome/cluser --password $(openssl passwd cluser) cluser

mkdir -p /chome /share
echo "${PHOST}:/chome       /chome      nfs auto,nofail,noatime,nolock,intr,tcp,actimeo=1800 0 0" >> /etc/fstab
echo "${PHOST}:/share       /share      nfs auto,nofail,noatime,nolock,intr,tcp,actimeo=1800 0 0" >> /etc/fstab
CNT=60
echo -n ">> Ping ${PHOST}: "
while [[ true ]];do
  ping -W1 -c1 ${PHOST} 2>&1 >/dev/null
  if [[ $? -ne 0 ]];then
    echo -n "."
    sleep 1
    CNT=$((${CNT}-1))
    if [[ $CNT -eq 0 ]];then
      echo " Limit reached! NOK!"
      break
    fi
    continue
  fi
  echo " OK"
  break
done
mount -a
