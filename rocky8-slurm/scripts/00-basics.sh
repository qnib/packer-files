#!/bin/bash -eux
yum install dnf-plugins-core
yum install -y epel-release
yum config-manager --set-enabled powertools
yum update -y
yum install -y vim wget rsync tcl environment-modules