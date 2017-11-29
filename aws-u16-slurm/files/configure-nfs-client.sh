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

if [[ $(cat /opt/slurm-type) == "master" ]];then
  echo ">> I am the slurm master, no need to mount myself! -> exit 0"
  exit 0
fi

set -x

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
