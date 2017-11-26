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

echo ">> Create user 'cluser' w/ creating home in /chome/cluser"
useradd --create-home -d /chome/cluser --password $(openssl passwd cluser) cluser

## Copy jobscripts and stuff over
rsync -aP /home/ubuntu/src/. /share/src/.
rsync -aP /home/ubuntu/slurm/. /share/slurm/.

chown -R ubuntu: /chome/ubuntu /share/*

## Configure server
echo "/chome/    *(rw,sync,no_subtree_check)" >> /etc/exports
echo "/share/    *(rw,sync,no_subtree_check)" >> /etc/exports
systemctl enable nfs-server
systemctl restart nfs-server
