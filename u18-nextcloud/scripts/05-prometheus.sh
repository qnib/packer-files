#!/bin/bash

cd /usr/local/bin
wget -q https://github.com/ChristianKniep/nextcloud-exporter/releases/download/2019-09-24.1/nextcloud-exporter
chmod +x nextcloud-exporter
cat << EOF > /etc/systemd/system/nextcloud_exporter.service
[Unit]
Description=Nextcloud Exporter

[Service]
User=nobody
EnvironmentFile=/etc/sysconfig/nextcloud_exporter
ExecStart=/usr/local/bin/nextcloud-exporter

[Install]
WantedBy=multi-user.target
EOF

mkdir -p /etc/sysconfig
systemctl enable nextcloud_exporter