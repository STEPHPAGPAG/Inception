#!/bin/sh

# Define the directory where WordPress is installed
wp_dir='/var/www/html'

# Check if the WordPress configuration file does not exist
if [ ! -e "${wp_dir}/wp-config.php" ]
then

	# Create the WordPress confuiguration file with the specified database settings
	wp config create	--allow-root \
				--dbname=$DB_NAME \
				--dbuser=$DB_USER \
				--dbpass=$DB_PASS \
				--dbhost=mariadb:3306 \
				--path=$wp_dir
	# Database name
	# Database user
	# Database password
	# Database host
	# WP install path

	# Install WordPress core files
	wp core install		--allow-root \
				--url=$WP_URL \
				--title=$WP_TITLE \
				--admin_email=$WP_ADMIN_EMAIL \
				--admin_user=$WP_ADMIN \
				--admin_password=$WP_ADMIN_PASS \
				--path=$wp_dir
	# Site URL
	# Site title
	# Admin email
	# Admin username
	# Admin password
	# WP install path

	# Create a new WordPress user
	wp user create		--allow-root \
				$WP_USER $WP_USER_EMAIL \
				--user_pass=$WP_USER_PASS \
				--path=$wp_dir
	# New user and email
	# New user's password
	# WP installation path

fi

/usr/sbin/php-fpm82 -F
# Start the PHP FastCGI Process Manager in the foreground