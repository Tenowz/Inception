FROM    debian:buster

RUN     apt-get update -y && apt upgrade -y && apt-get install mariadb-server -y
RUN     mkdir -p /var/run/mysqld && chown -R mysql:mysql /var/run/mysqld && chmod 777 /var/run/mysqld

COPY    conf/50-server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf

RUN     chmod 755 /etc/mysql/mariadb.conf.d/50-server.cnf

COPY    conf/db.sh /

CMD     ["sh", "db.sh"]