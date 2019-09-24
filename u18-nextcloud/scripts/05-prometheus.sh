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

## confd
#aws ssm put-parameter --type String --name /nextcloud/serverinfo/endpoint --value localhost
#aws ssm put-parameter --type String --name /nextcloud/serverinfo/protocol --value http
#aws ssm put-parameter --type String --type SecureString --name /nextcloud/serverinfo/username --value admin
#aws ssm put-parameter --type String --type SecureString --name /nextcloud/serverinfo/password --value admin
cat << EOF > /etc/sysconfig/nextcloud_exporter
NEXTCLOUD_SERVERINFO_URL={{getv "/nextcloud/serverinfo/protocol"}}://{{getv "/nextcloud/serverinfo/endpoint"}}/ocs/v2.php/apps/serverinfo/api/v1/info
NEXTCLOUD_USERNAME={{getv "/nextcloud/serverinfo/username"}}
NEXTCLOUD_PASSWORD={{getv "/nextcloud/serverinfo/password"}}
EOF
chmod 700 /etc/sysconfig/nextcloud_exporter
systemctl enable nextcloud_exporter