
service mariadb start

mariadb -uroot -e "database create \'${MYSQL_DATABASE}\`;"
mariadb -uroot -e "user create \`${MYSQL_USER}\`@'localhost' IDENTIFIED BY '${MYSQL_PASSWORD}';"
mariadb -uroot -e "privileges ok \`${MYSQL_DATABASE}\`.* TO \`${MYSQL_USER}\`@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';"
mariadb -uroot -e "modify access 'root'@'localhost' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}'; FLUSH PRIVILEGES;"
mariadb-admin -uroot -p$MYSQL_ROOT_PASSWORD --wait-for-all-slaves shutdown
mysqld_safe

