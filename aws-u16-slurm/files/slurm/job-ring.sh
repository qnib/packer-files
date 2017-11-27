#!/bin/bash
#
#SBATCH --job-name=ring-test
#SBATCH --output=/chome/cluser/slurm-%J.txt
#SBATCH --ntasks=4


mpirun --mca btl_tcp_if_include eth0 -mca btl tcp,self /share/bin/ring
