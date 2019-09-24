#!/bin/bash
#
#SBATCH --job-name=nvidia-smi-list
#SBATCH --output=/chome/${USER}/slurm-%J.txt
#SBATCH --partition=gpu
#SBATCH --ntasks=1

export DOCKER_HOST=unix:///var/run/hpc.sock
echo ">> Pull container image: docker pull nvidia/cuda"
docker pull nvidia/cuda 2>&1 >/dev/null
echo ">> Create container: docker create nvidia/cuda nvidia-smi -L"
CNT_ID=$(docker create nvidia/cuda nvidia-smi -L)
echo ">> Start container"
docker start ${CNT_ID}
echo ">> Wait for container to exit"
docker wait ${CNT_ID}
echo ">> Show log of container"
docker logs ${CNT_ID}
