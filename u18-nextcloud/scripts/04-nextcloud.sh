#!/bin/bash
set -x

cd /var/www/html
wget -qO- https://download.nextcloud.com/server/releases/nextcloud-16.0.4.tar.bz2 |tar xfj - --strip-components=1
mkdir data
touch data/.ocdata
wget -qO- https://github.com/nextcloud/polls/releases/download/v0.10.3/polls.tar.gz |tar xfz - -C apps/
wget -qO- https://github.com/nextcloud/text/releases/download/v1.0.2/text.tar.gz |tar xfz - -C apps/
wget -qO- https://github.com/nextcloud/richdocuments/releases/download/v3.4.2/richdocuments.tar.gz |tar xfz - -C apps/
wget -qO- https://github.com/nextcloud/calendar/releases/download/v1.7.1/calendar.tar.gz |tar xfz - -C apps/
wget -qO- https://github.com/nextcloud/contacts/releases/download/v3.1.3/contacts.tar.gz |tar xfz - -C apps/
wget -qO - https://github.com/nextcloud/serverinfo/archive/v17.0.0rc2.tar.gz |tar xfz - -C apps/
wget -qO - https://github.com/nextcloud/forms/releases/download/v.1.0.4/forms.tar.gz |tar xfz - -C apps/
chown www-data: -R *