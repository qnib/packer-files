#!/bin/bash -eux
yum install -y wget

mkdir -p /opt/sarus/
wget -qO- https://github.com/eth-cscs/sarus/releases/download/1.4.0/sarus-Release.tar.gz \
    |tar xfz - -C /opt/sarus/ --strip-component=1
/opt/sarus/configure_installation.sh
ln -s /etc/pki/ca-trust/extracted/pem/tls-ca-bundle.pem /etc/ssl/cert.pem

### 
cat > /etc/profile.d/sarus.sh <<EOF
export PATH=/opt/sarus/bin:${PATH}
EOF