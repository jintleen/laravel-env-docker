#!/bin/bash
chown www-data:www-data /app -R

source /etc/apache2/envvars
tail -F /var/log/apache2/* &
apache2ctl -D FOREGROUND