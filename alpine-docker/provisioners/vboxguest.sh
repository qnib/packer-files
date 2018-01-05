#!/bin/sh -ex
echo "http://nl.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories
apk update
apk add virtualbox-additions-grsec virtualbox-guest-additions virtualbox-guest-modules-grsec
echo vboxsf >> /etc/modules
echo vboxpci >> /etc/modules
echo vboxdrv >> /etc/modules
echo vboxnetflt >> /etc/modules
