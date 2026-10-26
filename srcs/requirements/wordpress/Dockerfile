FROM debian:bookworm

ENV DEBIAN_FRONTEND=noninteractive

RUN	apt-get update -y && \
	apt-get install -y --no-install-recommends \
	php8.2-fpm \
	php8.2-mysql \
	mariadb-client \
	curl \
	ca-certificates && \
	rm -rf /var/lib/apt/lists/*

#Copy config wp-cli
COPY tools/wp-cli.phar /usr/local/bin/wp
RUN chmod +x /usr/local/bin/wp

#Config directory web
RUN	mkdir -p /var/www/wordpress && \
	chown -R www-data:www-data /var/www/wordpress

COPY conf/www.conf /etc/php/8.2/fpm/pool.d/www.conf
COPY tools/auto_config.sh /usr/local/bin/auto_config.sh

RUN chmod +x /usr/local/bin/auto_config.sh

EXPOSE 9000

WORKDIR /var/www/wordpress

ENTRYPOINT ["/usr/local/bin/auto_config.sh"]
