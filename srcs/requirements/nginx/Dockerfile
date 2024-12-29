# Utilise l'image de base Debian Bullseye
FROM debian:bullseye

# Mise à jour des paquets et installer les dépendances nécessaires
RUN apt-get update && apt-get upgrade -y && \
    apt-get install -y nginx openssl php-fpm

# Création des répertoires nécessaires pour Nginx et SSL
RUN mkdir -p /etc/nginx/ssl /var/run/nginx /var/www/html

# Supprimer la configuration par défaut de Nginx
RUN rm -f /etc/nginx/sites-enabled/default

# Copie nginx.conf vers le dossier conf
COPY conf/nginx.conf /etc/nginx/sites-available/inception
RUN ln -s /etc/nginx/sites-available/inception /etc/nginx/sites-enabled/inception

# certificats SSL auto-signés
RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
    -out /etc/nginx/ssl/inception.crt \
    -keyout /etc/nginx/ssl/inception.key \
    -subj "/C=FR/ST=France/L=Paris/O=42/OU=spagliar/CN=spagliar.42.fr"

# COPY conf/nginx.conf /etc/nginx/http.d/default.conf

# répertoire par défaut pour servir les fichiers
WORKDIR /var/www/html

# S'assurer que Nginx et PHP fonctionnent avec les permissions correctes
RUN chown -R www-data:www-data /var/www/html && chmod -R 755 /var/www/html

EXPOSE 443

# Copier le point d'entrée pour lancer Nginx
CMD [ "nginx", "-g", "daemon off;" ]

