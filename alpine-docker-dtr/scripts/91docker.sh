set -eux

DOCKER_VER=17.10.0
apk --update add openssl
apk --update-cache \
    --repository http://nl.alpinelinux.org/alpine/edge/community \
    add 'docker>17.07'
wget -qO- https://github.com/qnib/docker-ce/releases/download/v${DOCKER_VER}-ce/docker-${DOCKER_VER}-ce.tar.gz |tar xfz - -C /
rc-update add docker
service docker start
