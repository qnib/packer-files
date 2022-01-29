# Create user without creating Home (-M), since it is already on the headnode
mkdir -p /nfs/home/
groupadd -g 2001 compute
useradd  -m -c "Alice is a compute user" -d /nfs/home/alice -u 2001 -g compute  -s /bin/bash alice
su - alice -c '< /dev/zero ssh-keygen -q -N ""'
su - alice -c 'cp ~/.ssh/id_rsa.pub ~/.ssh/authorized_keys'
cat << EOF > /nfs/home/alice/.ssh/config
Host *
    StrictHostKeyChecking no
    UserKnownHostsFile=/dev/null
EOF
chown alice: /nfs/home/alice/.ssh/config
useradd  -m -c "Bob is a compute user" -d /nfs/home/bob -u 2002 -g compute  -s /bin/bash bob
su - bob -c '< /dev/zero ssh-keygen -q -N ""'
su - bob -c 'cp ~/.ssh/id_rsa.pub ~/.ssh/authorized_keys'
cat << EOF > /nfs/home/bob/.ssh/config
Host *
    StrictHostKeyChecking no
    UserKnownHostsFile=/dev/null
EOF
chown bob: /nfs/home/bob/.ssh/config