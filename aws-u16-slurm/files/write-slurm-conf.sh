#!/bin/bash

echo ">> For startes assume the host is slurmctld an the only slurmd"
export CONTROL_MACHINE=$(hostname)
export CONTROL_MACHINE_ADDR=$(hostname -f )
echo ">> Stop slurmctld/slurmd"
systemctl stop slurmd
systemctl stop slurmctld
sleep 1
echo ">> Run `confd -onetime -backend env`"
confd -onetime -backend env

echo ">> Start slurmctld with a clean slate (-c)"
sed -i -e 's/#SLURMCTLD_OPTIONS=.*/SLURMCTLD_OPTIONS="-c"/' /etc/default/slurmctld

if [[ -f /home/ubuntu/etc/hosts.new ]];then
  echo ">> Add fixed set of hosts to /etc/hosts"
  echo "" >> /etc/hosts
  echo "## Fixed list of hosts to allow slurm-cluster to form" >> /etc/hosts
  cat /home/ubuntu/etc/hosts.new
  cat /home/ubuntu/etc/hosts.new >> /etc/hosts
  #rm -f /home/ubuntu/etc/hosts.new
fi

sleep 10
if [[ $(cat /opt/slurm-type) == "master" ]];then
  echo ">> Start slurmctld"
  systemctl start slurmctld
fi
echo ">> Start slurmd"
systemctl start slurmd

echo ">> Restart doxy for good measure"
systemctl restart doxy
