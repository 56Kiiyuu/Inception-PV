#!/bin/sh

#wait until MariaDB has started before connection
echo "START AUTO_CONFIG"
echo "wait connection to MariaDB..."
while ! mariadb-admin ping -h"mariadb" --silent; do
    sleep 2
done
echo "MariaDB ready"

cd /var/www/wordpress

if [ ! -f wp-config.php ]; then

	#DL files in WP
	echo "DL WordPress..."
	wp core download --allow-root
	#create file wp-config.php link with MariaDB
	echo "wp-config.php..."
	wp config create \
		--dbname="${SQL_DATABASE}" \
		--dbuser="${SQL_USER}" \
		--dbpass="${SQL_PASSWORD}" \
		--dbhost="mariadb:3306" \
		--path='/var/www/wordpress' \
		--allow-root

	#Install website and create AdminUser
	echo "Installation WordPress..."
	wp core install \
		--url="https://${DOMAIN_NAME}" \
		--title="Inception 42" \
		--admin_user="${WORDPRESS_ADMIN_USER}" \
		--admin_password="${WORDPRESS_ADMIN_PASSWORD}" \
		--admin_email="${WORDPRESS_ADMIN_EMAIL}" \
		--skip-email \
		--allow-root

	echo "create user..."
	wp user create \
		"${WORDPRESS_USER}" \
		"${WORDPRESS_EMAIL}" \
		--role=author \
		--user_pass="${WORDPRESS_PASSWORD}" \
		--allow-root
fi

#permission to www-data

chown -R www-data:www-data /var/www/wordpress
chmod -R 755 /var/www/wordpress

#create directory for socket/run PHP-FPM
mkdir -p /run/php

exec php-fpm8.2 -F
