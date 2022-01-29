# Create user without creating Home (-M), since it is already on the headnode
groupadd -g 2001 compute
useradd  -M -c "Alice is a compute user" -d /nfs/home/alice -u 2001 -g compute  -s /bin/bash alice
useradd  -M -c "Bob is a compute user" -d /nfs/home/bob -u 2002 -g compute  -s /bin/bash bob
