
#!/usr/bin/env bash
set -e

mkdir -p /var/www/moodledata
chown -R www-data:www-data /var/www/moodledata

CONFIG_FILE="/var/www/html/config.php"

if [ -f "$CONFIG_FILE" ]; then
    sed -i "s#\$CFG->wwwroot = .*#\$CFG->wwwroot = 'https://mdl.deltlabs.net';#" "$CONFIG_FILE"

    if grep -q "sslproxy" "$CONFIG_FILE"; then
        sed -i "s#\$CFG->sslproxy = .*#\$CFG->sslproxy = true;#" "$CONFIG_FILE"
    else
        sed -i "/\$CFG->wwwroot/a \$CFG->sslproxy = true;" "$CONFIG_FILE"
    fi
fi

exec "$@"
