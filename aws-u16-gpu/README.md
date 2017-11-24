# Deep Learning Base AMI w/ docker

This `packer.json` inherits from the official `Deep Learning Base AMI` image (as of this writing `ami-f346c289`) and add docker capabilities to allow transparent GPU use.


## Using the instance

Start the AMI on EC2 using a GPU instance (e.g. p2.xlarge).

```bash
$ ssh -l ubuntu ec2-XX-XXX-XXX-XXX.compute-1.amazonaws.com
ubuntu@ip-xx:~$ sudo -i
# For good measure, I have to add a little delay
root@ip-xx:~# systemctl restart doxy
root@ip-xx:~# docker -H unix:///var/run/hpc.sock create nvidia/cuda nvidia-smi -L
Unable to find image 'nvidia/cuda:latest' locally
latest: Pulling from nvidia/cuda
*snip*
Status: Downloaded newer image for nvidia/cuda:latest
5ad145313775e784ee42ed96165dd0122a318b62dc680d365ea57411e3791354
root@ip-xx:~# docker start -a 5ad145313775e784ee42ed96165dd0122a318b62dc680d365ea57411e3791354
GPU 0: Tesla K80 (UUID: GPU-f0dcd189-ddb7-138f-8694-194d2d1771d2)
root@ip-xx:~#
```
