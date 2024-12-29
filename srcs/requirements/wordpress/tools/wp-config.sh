#!/bin/sh

# Répertoires et chemins par défaut
WP_DIR=${WP_DIR:-/var/www/html}
if [ ! -e "${WP_DIR}/wp-config.php" ]
then

# Configuration initiale
wp config create --allow-root \
                 --dbname="$MDB_NAME" \
                 --dbuser="$MDB_USER" \
                 --dbpass="$MDB_PASS" \
                 --dbhost=mariadb:3306 \
                 --path="$WP_DIR"

# Installation de WordPress
wp core install --allow-root \
                --url="$WP_URL" \
                --title="$WP_TITLE" \
                --admin_user="$WP_ADMIN" \
                --admin_password="$WP_ADMIN_PASS" \
                --admin_email="$WP_ADMIN_EMAIL" \
                --skip-email \
                --path="$WP_DIR"

# Ajout d'un utilisateur
wp user create "$WP_USER" "$WP_USER_EMAIL" \
               --allow-root \
               --role=subscriber \
               --user_pass="$WP_USER_PASS"

# Mise à jour des options
wp option update home 'https://spagliar.42.fr' --allow-root
wp option update siteurl 'https://spagliar.42.fr' --allow-root

else
    echo "wordpress config already completed"
fi

# Lancement de PHP-FPM en arriere plan
/usr/sbin/php-fpm7.4 -F



