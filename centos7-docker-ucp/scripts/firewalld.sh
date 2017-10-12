#!/bin/bash

systemctl start firewalld

for x in 12383 12381 12380 12379 12386 2378 12376 12385 9443 12387 12382 12384;do
    firewall-cmd --zone=public --permanent --add-port=$x/tcp
done
