FROM debian:bookworm

ENV DEBIAN_FRONTEND=noninteractive

RUN	apt-get update -y && \
	apt-get install -y --no-install-recommends \
	mariadb-server \
	mariadb-client \
	procps && \
	rm -rf /var/lib/apt/lists/*

RUN	mkdir -p /var/run/mysqld && \
	chown -R mysql:mysql /var/run/mysqld && \
	chmod 777 /var/run/mysqld

COPY conf/50-server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf
COPY tools/mariadb.sh /usr/local/bin/mariadb.sh

RUN chmod +x /usr/local/bin/mariadb.sh

EXPOSE 3306

ENTRYPOINT ["mariadb.sh"]
