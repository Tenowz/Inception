FROM	debian:buster

RUN		apt-get update && apt-get install -y curl wget php php-fpm php-mysql php-mysqli php-json php-dom php-exif php-fileinfo php-mbstring php-gd php-xml php-zip php-curl mariadb-client
RUN		mkdir -p /run/php

COPY	./conf/www.conf /etc/php/7.3/fpm/pool.d/

WORKDIR	/var/www/html/

COPY	./conf/auto_config.sh .

RUN		chmod 777 ./auto_config.sh

ENTRYPOINT ./auto_config.sh