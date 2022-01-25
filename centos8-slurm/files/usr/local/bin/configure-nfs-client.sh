#!/bin/bash
export PHOST=headnode

mkdir -p /nfs/{home,share}
echo "${PHOST}:/nfs/home       /nfs/home    nfs auto,nofail,noatime,nolock,intr,tcp,actimeo=1800 0 0" |tee -a /etc/fstab
echo "${PHOST}:/nfs/share      /nfs/share   nfs auto,nofail,noatime,nolock,intr,tcp,actimeo=1800 0 0" |tee -a /etc/fstab

## Wait for headnode to be in /etc/hosts
canary_line=${PHOST}
file='/etc/hosts'

echo 'Waiting for headnode to be discoverable'

until grep -q "${canary_line}" "${file}"
do
  echo -n "."
  sleep 1s
done
echo "OK"
mount /nfs/home
mount /nfs/share
