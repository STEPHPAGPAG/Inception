FROM debian:bullseye

#installation des outils necessaires  et mise a jour des paquets
RUN     apt-get update && apt-get upgrade -y
RUN     apt-get install                 \
                        wget            \
                        php             \
                        php-fpm         \
                        php-cli         \
                        php-mysql       \
                        mariadb-client  \
                        netcat          \
                        -y

#creation de repertoire et ajuste les permissions pour stocker les fichiers wordpress
RUN     mkdir -p /var/www/html

RUN     mkdir -p /run/php
#attention on change utilisateur par defaut
RUN     chown -R www-data:www-data /run/php

#Telecharge et installe wordpress
RUN     wget https://wordpress.org/latest.tar.gz -P /var/www/ && \
        tar -xvf /var/www/latest.tar.gz -C /var/www/html --strip-components=1 && \
        rm -rf /var/www/latest.tar.gz && \
        chown -R www-data:www-data /var/www/html

#installe command line interface 
RUN     wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
        chmod +x wp-cli.phar && \
        mv wp-cli.phar /usr/local/bin/wp

#ecoute sur le port 9000
# COPY ./conf/www.conf /etc/php/7.4/fpm/pool.d/www.conf
COPY ./conf/www.conf /config/www.conf
EXPOSE 9000

#copy over config script and give permissions
COPY ./tools/wp-config.sh /wp-config.sh
RUN   chmod +x /wp-config.sh

ENTRYPOINT ["/wp-config.sh"]
