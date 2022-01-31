#!/bin/bash -eux
yum install -y git gcc-c++ gcc-gfortran autoconf
pip3 install boto3 awscli
groupadd -g 3000 spack
usermod -aG spack vagrant
git clone -c feature.manyFiles=true https://github.com/spack/spack.git /opt/spack

### Enable binary cache

mkdir -p /nfs/share/spack/{pkg,cache}
chmod 775 -R /nfs/share/spack/{pkg,cache}
chgrp -R spack /nfs/share/spack/{pkg,cache}
## Spack modules
mkdir -p  /nfs/share/spack/{modules,lmod}
chmod 775 -R  /nfs/share/spack/{modules,lmod}
chgrp -R spack /nfs/share/spack/{modules,lmod}
### 
##Error: [Errno 13] Permission denied: '/nfs/share/spack/pkg/.spack-db'
source /opt/spack/share/spack/setup-env.sh
export BUILD_CACHE=spack-vagrant-bins
spack mirror add ${BUILD_CACHE} "s3://${BUILD_CACHE}.qnib.org"


cat > /etc/profile.d/spack.sh <<EOF
source /opt/spack/share/spack/setup-env.sh
EOF

cat > /opt/spack/etc/spack/config.yaml << \EOF
config:
  # This is the path to the root of the Spack install tree.
  # You can use $spack here to refer to the root of the spack instance.
  install_tree:
    root: /nfs/share/spack/pkg
  # Cache directory for already downloaded source tarballs and archived
  # repositories. This can be purged with `spack clean --downloads`.
  source_cache: /nfs/share/spack/cache


  # Cache directory for miscellaneous files, like the package index.
  # This can be purged with `spack clean --misc-cache`
  misc_cache: ${HOME}/cache
EOF

cat > /opt/spack/etc/spack/modules.yaml << EOF
# -------------------------------------------------------------------------
# This is the default configuration for Spack's module file generation.
#
# Settings here are versioned with Spack and are intended to provide
# sensible defaults out of the box. Spack maintainers should edit this
# file to keep it current.
#
# Users can override these settings by editing the following files.
#
# Per-spack-instance settings (overrides defaults):
#   $SPACK_ROOT/etc/spack/modules.yaml
#
# Per-user settings (overrides default and site settings):
#   ~/.spack/modules.yaml
# -------------------------------------------------------------------------
modules:
  # Paths to check when creating modules for all module sets
  prefix_inspections:
    bin:
      - PATH
    man:
      - MANPATH
    share/man:
      - MANPATH
    share/aclocal:
      - ACLOCAL_PATH
    lib/pkgconfig:
      - PKG_CONFIG_PATH
    lib64/pkgconfig:
      - PKG_CONFIG_PATH
    share/pkgconfig:
      - PKG_CONFIG_PATH
    '':
      - CMAKE_PREFIX_PATH

  # These are configurations for the module set named "default"
  default:
    # These values are defaulted in the code. They are not defaulted here so
    # that we can enable backwards compatibility with the old syntax more
    # easily (old value is in the config yaml, config:module_roots)
    # Where to install modules
    roots:
     tcl:    /nfs/share/spack/modules
     lmod:   /nfs/share/spack/lmod
    # What type of modules to use
    enable:
      - tcl
    tcl:
      all:
        autoload: none

    # Default configurations if lmod is enabled
    lmod:
      all:
        autoload: direct
      hierarchy:
        - mpi
EOF

cat > /opt/spack/etc/spack/compilers.yaml << EOF
compilers:
- compiler:
    spec: gcc@8.5.0
    paths:
      cc: /usr/bin/gcc
      cxx: /usr/bin/g++
      f77: /usr/bin/gfortran
      fc: /usr/bin/gfortran
    flags: {}
    operating_system: centos8
    target: x86_64
    modules: []
    environment: {}
    extra_rpaths: []
EOF