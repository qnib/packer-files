#!/bin/bash
set -x

lsof /var/lib/dpkg/lock
rm -f /var/lib/dpkg/lock
dpkg --configure -a

apt-get update
rm -f /var/lib/dpkg/lock
apt-get install -y \
  autoconf \
  flex \
  g++ \
  libevent-dev \
  libgtk2.0-dev \
  libmunge-dev \
  libpmi2-0 \
  libpmi2-0-dev \
  libtool \
  make \
  munge


### PMIx
git clone https://github.com/pmix/pmix.git /usr/local/src/pmix/pmix
cd /usr/local/src/pmix/pmix
git checkout v2.1
./autogen.sh
./configure --prefix=/usr/ && make -j4 && make install

## SLURM
useradd -s /bin/false slurm
wget -qO - https://download.schedmd.com/slurm/slurm-17.11.0-0rc3.tar.bz2 |tar xfj - -C /usr/local/src/
cd /usr/local/src/slurm-17.11.0-0rc3
./autogen.sh
./configure --prefix=/usr/ && make -j4 && make install
# Configure SLURM
ln -s /etc/slurm/slurm.conf /usr/etc/
mkdir -p /var/run/slurm/
echo '#SLURMCTLD_OPTIONS=""' > /etc/default/slurmctld
touch /etc/default/slurmd

mv /home/ubuntu/systemd/slurmconfig.service /lib/systemd/system/
mv /home/ubuntu/write-slurm-conf.sh /usr/local/bin/
mv /home/ubuntu/systemd/slurmconfig.service /lib/systemd/system/
mv /home/ubuntu/systemd/slurmd.service /lib/systemd/system/
mv /home/ubuntu/systemd/slurmctld.service /lib/systemd/system/
systemctl enable slurmconfig

mv /home/ubuntu/munge.key /etc/munge/
chown munge: /etc/munge/munge.key
chmod 400 /etc/munge/munge.key
