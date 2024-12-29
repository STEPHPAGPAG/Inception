FROM debian:bullseye

# Mise à jour et installation de MariaDB
RUN apt-get update && apt-get upgrade -y && \
    apt-get install -y mariadb-server mariadb-client

# Copier les fichiers de configuration et le script d'entrée
COPY ./conf/50.server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf
COPY ./tools/init-db.sh /init-db.sh

# Rendre le script exécutable
RUN chmod +x /init-db.sh

# port par défaut de MariaDB
EXPOSE 3306

#run maria 
ENTRYPOINT ["/init-db.sh"]