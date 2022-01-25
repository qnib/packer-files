yum install -y nfs-utils
systemctl enable nfs-server.service

### setup dir
mkdir -p  /nfs/{home,share}
cat > /etc/exports << EOF
/nfs/home     *(rw,sync)
/nfs/share    *(rw,sync)
EOF