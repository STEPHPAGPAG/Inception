# Use Alpine Linux version 3.19 as the base image
FROM alpine:3.19

# Update package index and upgrade existing packages
RUN apk update && apk upgrade
# Install PHP and required extensions without cache to reduce image size
RUN apk add --no-cache \
		php-fpm \
		php-mysqli \
		php-phar \
		php-iconv \
		wget
# PHP FastCGI Process Manager
# MySQL Improved extension for PHP
# PHAR (PHP Archive) support
# Support for character set conversions
# Command-line tool to download files

# Create the directory for serving web files
RUN mkdir -p /var/www/html
# Set the working directory to /var/www/html
WORKDIR /var/www/html

# Download the specified version of WordPress
RUN wget https://wordpress.org/wordpress-6.4.3.tar.gz
# Extract WordPress files, removing the top-level directory
RUN tar -xzf wordpress-6.4.3.tar.gz --strip-components 1
# Remove the downloaded tar file to save space
RUN rm wordpress-6.4.3.tar.gz

# Download the WP-CLI (WordPress Command Line Interface) script
RUN wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
# Make the WP-CLI script executable
RUN chmod u+x wp-cli.phar
# Move the WP-CLI script to a directory in the PATH
RUN mv wp-cli.phar /usr/local/bin/wp

# Copy the custom PHP-FPM configuration into the container
COPY conf/www.conf /etc/php82/php-fpm.d/www.conf
# Copy the entrypoint script into the container
COPY tools/wp-config.sh /wp-config.sh

# Make the entrypoint script executable
RUN chmod u+x /wp-config.sh

# Set the entrypoint to run the script when the container starts
ENTRYPOINT ["/wp-config.sh"]