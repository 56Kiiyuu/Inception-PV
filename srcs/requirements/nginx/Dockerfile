FROM debian:bookworm

ENV DEBIAN_FRONTEND=noninteractive

RUN	apt-get update -y && \
	apt-get install -y --no-install-recommends \
	nginx \
	openssl \
	curl && \
	rm -rf /var/lib/apt/lists/*

# create directory for SSL and create key/certificate
RUN mkdir -p /etc/nginx/ssl && \
	openssl req -x509 -nodes -out /etc/nginx/ssl/inception.crt -keyout /etc/nginx/ssl/inception.key -subj "/C=FR/ST=IDF/L=Paris/O=42/OU=42/CN=kevlim.42.fr/UID=kevlim"

COPY conf/nginx.conf /etc/nginx/nginx.conf

# Permissions directory web
RUN mkdir -p /var/www/wordpress && \
	chown -R www-data:www-data /var/www/wordpress

EXPOSE 443

CMD ["nginx", "-g", "daemon off;"]
