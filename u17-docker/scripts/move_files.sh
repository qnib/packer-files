#!/bin/bash
set -x

mv /home/vagrant/daemon.json /etc/docker/daemon.json
mv /home/vagrant/docker.service /lib/systemd/system/docker.service

