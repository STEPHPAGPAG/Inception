FROM debian : Bookworm
RUN apt-get update && \
    apt-get upgrade
expose 443 
#le conteneur ecoutera ce port-> pour les connexions HTTPS

RUN apt-get install -y --no-install-recommends nginx openssl #nginx->serveur web openssl ->pour gerer les certif ssl
RUN mkdir -p /etc/nginx/ssl #rep pour stocker les fichiers ssl

RUN openssl req -x509 -nodes -days 365 -newkey rsa:4096 \
    -keyout /etc/nginx/ssl/nginx.key -out /etc/nginx/ssl/nginx.crt \
    -subj "/C=PT/ST=Porto/L=Porto/O=42 Porto/CN=andvieir.42.fr"
#certificat SSL auto signe

COPY /tmp/
COPY /conf/nginx.conf /etc/nginx/
#copie les fichiers de configuration

RUN chmod 755 /var/www/html
RUN chown -R www-data:www-data /var/www/html
#modif les permissions -> lecture ecriture

CMD ["sh", "-c", "/bin/bash /tmp/entrypoint.sh;"]