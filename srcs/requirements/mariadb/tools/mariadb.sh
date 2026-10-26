#!/bin/sh

# Start tempo MySQL
service mariadb start

sleep 2

# Create BDD if dont exist

if [ ! -d "/var/lib/mysql/${SQL_DATABASE}" ]; then

	mysql -e "CREATE DATABASE IF NOT EXISTS \`${SQL_DATABASE}\`;"
	mysql -e "CREATE USER IF NOT EXISTS \`${SQL_USER}\`@'%' IDENTIFIED BY '${SQL_PASSWORD}';"
	mysql -e "GRANT ALL PRIVILEGES ON \`${SQL_DATABASE}\`.* TO \`${SQL_USER}\`@'%';"
	mysql -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '${SQL_ROOT_PASSWORD}';"
	mysql -e "FLUSH PRIVILEGES;"

	#shutdown after init
	mysqladmin -u root -p"${SQL_ROOT_PASSWORD}" shutdown
else
	mysqladmin -u root -p"${SQL_ROOT_PASSWORD}" shutdown 2>/dev/null || service mariadb stop
fi

#start MariaDB (PID 1)
exec mysqld_safe
