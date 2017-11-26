# Deep Learning Base AMI w/ docker + slurm

This `packer.json` inherits from the `aws-u16-gpu` image (by default) and adds a SLURM cluster to it.


## Using the instance

Start the AMI on EC2 using a GPU instance (e.g. p2.xlarge).

```bash
$ ssh -l ubuntu ec2-XX-XXX-XXX-XXX.compute-1.amazonaws.com
ubuntu@ip-xx:~$ sinfo
PARTITION AVAIL  TIMELIMIT  NODES  STATE NODELIST
all*         up   infinite      1   idle ip-10-0-28-151
ubuntu@ip-xx:~$ sbatch job-gpu.sh
Submitted batch job 2
ubuntu@ip-xx:~$ squeue
             JOBID PARTITION     NAME     USER ST       TIME  NODES NODELIST(REASON)
                 2       all nvidia-s   ubuntu  R       0:01      1 ip-10-0-28-151
                 tail -f !$
ubuntu@ip-xx:~$ tail -f slurm-2.out
>> Pull container image: docker pull nvidia/cuda
>> Create container: docker create nvidia/cuda nvidia-smi -L
>> Start container
7578b3b0e47780b4953a7a822af31af26a426b9360fab2f38255a9bcec680214
>> Wait for container to exit
0
>> Show log of container
GPU 0: Tesla K80 (UUID: GPU-fd6786c1-7a7b-a29a-e4f5-86e9a13b645e)
```
