#!/bin/sh -ex

echo """http://mirror.leaseweb.com/alpine/v3.7/main
http://mirror.leaseweb.com/alpine/v3.7/community
http://mirror.leaseweb.com/alpine/edge/main
http://mirror.leaseweb.com/alpine/edge/community
http://nl.alpinelinux.org/alpine/edge/testing""" > /etc/apk/repositories
apk update
apk add virtualbox-additions-grsec virtualbox-guest-additions virtualbox-guest-modules-grsec
echo vboxsf >> /etc/modules
echo vboxpci >> /etc/modules
echo vboxdrv >> /etc/modules
echo vboxnetflt >> /etc/modules
