if [ -d "/var/lib/mysql/$SQL_DATABASE" ]
then
	echo "database exists"
else
    echo "creation of db"
    
    mysql_install_db --basedir=/usr --datadir=/var/lib/mysql/ --user=mysql --skip-test-db >> /dev/null

    mysqld -u mysql --bootstrap << EOF
        USE mysql;
        FLUSH PRIVILEGES;
        DELETE FROM mysql.user WHERE User='root' AND Host NOT IN ('localhost', '127.0.0.1', '::1');
        ALTER USER 'root'@'localhost' IDENTIFIED BY '$SQL_ROOT_PASSWORD';
        CREATE DATABASE $SQL_DATABASE CHARACTER SET 'utf8' COLLATE 'utf8_general_ci';
        CREATE USER '$SQL_USER'@'localhost' IDENTIFIED BY '$SQL_PASSWORD';
        GRANT ALL PRIVILEGES ON $SQL_DATABASE.* TO '$SQL_USER'@'%' IDENTIFIED BY '$SQL_PASSWORD';
        FLUSH PRIVILEGES;
EOF

fi
exec mysqld --user=mysql --console
