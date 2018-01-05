#!/bin/bash

groupadd -g 1002 cluser
useradd -d /home/cluser --uid 1002 --gid 1002 cluser
