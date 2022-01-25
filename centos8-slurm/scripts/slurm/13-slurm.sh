## Fetch tar
  yum install -y wget python3 make json-c-devel http-parser-devel
  export VER=21.08.5
  wget -q https://download.schedmd.com/slurm/slurm-${VER}.tar.bz2
  ### Build
  rpmbuild -ta slurm-$VER.tar.bz2 --with mysql --with slurmrestd
  cd /root/rpmbuild/RPMS/x86_64/
  export VER=21.08.5-1
  yum install -y slurm-$VER*rpm slurm-devel-$VER*rpm slurm-perlapi-$VER*rpm slurm-torque-$VER*rpm slurm-slurmctld-$VER*rpm slurm-slurmd-$VER*rpm slurm-example-configs-$VER*rpm
  ### PMI + RestD
  yum install -y slurm-libpmi-$VER*rpm slurm-slurmrestd-$VER*rpm
  