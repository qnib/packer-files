#!/bin/sh -ex
mount -t ext4 /dev/sda3 /mnt
apk add --root=/mnt openssl
apk add --root=/mnt sudo
apk add --root=/mnt openssh
ln -s /etc/init.d/sshd /mnt/etc/runlevels/default/sshd
cp /mnt/etc/ssh/sshd_config /tmp/sshd_config
sed \
  -e 's/^#PermitRootLogin .*/PermitRootLogin yes/' \
  -e 's/^#PubkeyAuthentication yes/PubkeyAuthentication yes/' \
  -e 's/^#PasswordAuthentication yes/PasswordAuthentication yes/' \
  -e 's/^#UseDNS no/UseDNS no/' /tmp/sshd_config > /mnt/etc/ssh/sshd_config
rm /tmp/sshd_config
echo http://dl-cdn.alpinelinux.org/alpine/v3.7/community >> /etc/apk/repositories
apk add -U virtualbox-guest-additions virtualbox-guest-modules-hardened
rc-update add virtualbox-guest-additions
echo vboxsf >> /etc/modules
reboot
