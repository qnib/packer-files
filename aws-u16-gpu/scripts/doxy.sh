#!/bin/bash

wget -qO /usr/bin/doxy https://github.com/qnib/doxy/releases/download/v0.2.1/doxy_x86_v0.2.1
chmod +x /usr/bin/doxy
## SystemD
mv /home/ubuntu/doxy.service /lib/systemd/system/
systemctl enable doxy
