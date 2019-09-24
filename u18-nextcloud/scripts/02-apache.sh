#!/bin/bash
set -x

apt update
apt-get install -y \
  apache2 php7.2 bzip2 \
  libapache2-mod-php php-gd php-json php-mysql php-curl php-mbstring \
  php-intl php-imagick php-xml php-zip
