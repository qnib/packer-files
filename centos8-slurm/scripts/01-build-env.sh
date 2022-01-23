#!/bin/bash -eux

dnf config-manager --set-enabled powertools
dnf install -y epel-release


yum install -y gcc \
    gtk2-devel \
    hwloc \
    hwloc-devel \
    libibmad \
    lua \
    lua-devel \
    ncurses-devel \
    numactl \
    numactl-devel \
    openssl \
    openssl-devel \
    pam-devel \
    perl-ExtUtils-MakeMaker \
    perl-Switch \
    readline-devel \
    rpm-build \
    rrdtool-devel \
    xorg-x11-xauth
