
#!/usr/bin/env bash
set -e

mkdir -p /var/www/moodledata
chown -R www-data:www-data /var/www/moodledata

CONFIG_FILE="/var/www/html/config.php"

if [ -f "$CONFIG_FILE" ]; then
    sed -i "s#\$CFG->wwwroot = .*#\$CFG->wwwroot = 'https://mdl.deltlabs.net';#" "$CONFIG_FILE"

    sed -i "/\$CFG->sslproxy = true;/d" "$CONFIG_FILE"
    echo "\$CFG->sslproxy = true;" >> "$CONFIG_FILE"
fi

exec "$@"
