# SARUS runtime

## AMI

The AMI installs some toolings like `bsdtar`, `awscli` as well as SARUS plus its dependencies.

 - NVIDIA: `nvidia-driver`, `libnvidia-container`, `container-runtime-config`, SARUS compiles a hook
 - SSH: compiles a hook
 - MPI: enabled the MPI hook

### build using packer

To build an AMI, just run the following command.

```
$ packer build packer.json
```