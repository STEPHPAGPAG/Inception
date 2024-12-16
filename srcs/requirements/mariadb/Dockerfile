FROM debian : Bookworm  # tte l image sera construite a partir de cette image de base

EXPOSE 3306 #expose le port utilise pour les connexions entrantres mariadb

RUN apt update && apt install -y --no-install-recommends --no-install-suggests
RUN mariadb-server && rm -rf /var/lib/apt/lists/*

COPY conf/50-server.cnf /etc/mysql/mariadb.conf.d/
COPY tools/entrypoint.sh /bin/
RUN chmod +x /bin/entrypoint.sh

CMD ["entrypoint.sh", "mysqld_safe"]
