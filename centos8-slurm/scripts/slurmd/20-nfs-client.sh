yum install -y nfs-utils nfs4-acl-tools

cp /home/vagrant/usr/local/bin/configure-nfs-client.sh /usr/local/bin/configure-nfs-client.sh
chmod +x /usr/local/bin/configure-nfs-client.sh
cp /home/vagrant/usr/lib/systemd/system/nfsclient.service /lib/systemd/system/nfsclient.service
systemctl enable nfsclient