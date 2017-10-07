#!/bin/bash

echo "####### Clone runc"
export GOPATH=/usr/local/
git clone https://github.com/opencontainers/runc.git /usr/local/src/github.com/opencontainers/runc/
cd /usr/local/src/github.com/opencontainers/runc/
#echo "####### Build runc within golang container"
ln -s /usr/lib/go-1.8/bin/go /usr/bin/
go get -u
make
cp runc /usr/local/bin/
