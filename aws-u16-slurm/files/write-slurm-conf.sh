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
echo ">> Start slurmctld/slurmd"
systemctl start slurmctld
systemctl start slurmd

echo ">> Restart doxy for good measure"
systemctl restart doxy
