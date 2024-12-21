
if [[ ! -e "${WP_DIR}/wp-config.php" ]]; then
   
wp config create    --allow-root            \
                    --db_name=$MDB_NAME     \
                    --db_user=$MDB_USER     \
                    --db_pass=$MDB_PASS     \
                    --db_host=mariadb:3306  \
                    --path=$WP_DIR

 
wp core install     --allow-root                    \
                    --url=$WP_URL                   \
                    --title=$WP_TITLE               \
                    --admin_user=$WP_ADMIN          \
                    --admin_password=$WP_ADMIN_PASS \
                    --admin_email= $WP_ADMIN_EMAIL  \
                    --skip-email                    \
                    --path=$WP_DIR

wp user create      $WP_USER $WP_USER_EMAIL     \
                    --allow-root                \
                    --role=subscriber           \
                    --user_pass=$WP_USER_PASS

wp option update home 'https://spagliar.42.fr' --allow-root
wp option update siteurl 'https://spagliar.42.fr' --allow-root

else
    echo "wordpress config already completed"
fi

/usr/sbin/php-fpm7.4 -F

#https://developer.wordpress.org/cli/commands/
#https://developer.wordpress.org/cli/commands/config/create/
