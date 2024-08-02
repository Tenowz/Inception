#!/bin/bash

while ! mysqladmin ping -h$SQL_HOST -u$SQL_USER -p$SQL_PASSWORD --silent; do
	echo "waiting for mariadb..."
	sleep 3
done

if [ ! -f "wp-config.php" ];
then
	curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
	chmod +x wp-cli.phar
	mv wp-cli.phar /usr/local/bin/wp 

	wp core download --allow-root
	wp config create --dbhost=$SQL_HOST --dbname=$SQL_DATABASE --dbuser=$SQL_USER --dbpass=$SQL_PASSWORD --allow-root
	wp core install --url=$WP_URL/ --title=$WP_TITLE --admin_user=$WP_ADMIN --admin_password=$WP_ADMIN_PASSWORD --admin_email=$WP_ADMIN_EMAIL --skip-email --allow-root
	wp user create $WP_USER_NAME $WP_USER_EMAIL --role=author --user_pass=$WP_USER_PASSWORD --allow-root
fi

php-fpm7.3 -F