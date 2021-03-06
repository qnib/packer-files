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

if [[ $(cat /opt/slurm-type) != "master" ]];then
  echo ">> I am '$(cat /opt/slurm-type)' NOT the master -> exit 0"
  exit 0
fi

mkdir -p /share/{slurm,src,bin}
mkdir -p /chome/ubuntu

## Copy jobscripts and stuff over
rsync -aP /home/ubuntu/src/. /share/src/.
rsync -aP /home/ubuntu/slurm/. /share/slurm/.
rsync -aP /home/ubuntu/bin/. /share/bin/.

chown -R ubuntu: /chome/ubuntu /share/*

## Configure server
echo "/chome/    *(rw,sync,no_subtree_check)" >> /etc/exports
echo "/share/    *(rw,sync,no_subtree_check)" >> /etc/exports
systemctl enable nfs-server
systemctl restart nfs-server
