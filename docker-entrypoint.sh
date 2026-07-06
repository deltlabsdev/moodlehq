#!/usr/bin/env bash
set -e

mkdir -p /var/www/moodledata
chown -R www-data:www-data /var/www/moodledata

CONFIG_FILE="/var/www/html/config.php"

if [ -f "$CONFIG_FILE" ]; then
    python3 <<'PY'
from pathlib import Path

cfg = Path("/var/www/html/config.php")

text = cfg.read_text()

# Remove old settings
lines = []
for line in text.splitlines():
    if "$CFG->wwwroot" in line:
        continue
    if "$CFG->sslproxy" in line:
        continue
    lines.append(line)

# Add desired settings exactly once
lines.append("$CFG->wwwroot = 'https://mdl.deltlabs.net';")
lines.append("$CFG->sslproxy = true;")

cfg.write_text("\n".join(lines) + "\n")
PY
fi

exec apache2-foreground