FROM moodlehq/moodle-php-apache:8.3

USER root

RUN apt-get update \
    && apt-get install -y --no-install-recommends git ca-certificates \
    && rm -rf /var/lib/apt/lists/*

RUN rm -rf /var/www/html/* \
    && git clone --depth 1 -b MOODLE_502_STABLE https://github.com/moodle/moodle.git /var/www/html \
    && chown -R www-data:www-data /var/www/html

COPY docker-entrypoint.sh /usr/local/bin/docker-entrypoint.sh
RUN chmod +x /usr/local/bin/docker-entrypoint.sh

ENTRYPOINT ["docker-entrypoint.sh"]
CMD ["apache2-foreground"]