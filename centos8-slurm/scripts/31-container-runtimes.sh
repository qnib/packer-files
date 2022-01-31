#!/bin/bash -eux
yum install -y runc crun git

#yum install -y \
#      cargo          \
#      pkg-config     \
#      systemd-devel  \
#      dbus-devel     \
#      elfutils-libelf-devel \
#      libseccomp-devel
#curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
#source $HOME/.cargo/env && rustup default nightly && rustup update
#git clone https://github.com/containers/youki.git /usr/local/src/youki
#cd /usr/local/src/youki
#./build.sh
