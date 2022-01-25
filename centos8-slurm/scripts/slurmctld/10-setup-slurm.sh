## Cp config
cp /home/vagrant/etc/slurm/slurm.conf /etc/slurm/slurm.conf
## Enable service
systemctl enable munge
systemctl enable slurmctld
systemctl enable slurmd

