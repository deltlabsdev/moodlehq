#!/usr/bin/env bash
set -e

mkdir -p /var/www/moodledata
chown -R www-data:www-data /var/www/moodledata

exec "$@"