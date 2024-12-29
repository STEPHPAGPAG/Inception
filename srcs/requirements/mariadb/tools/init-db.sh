#!/bin/sh 

# lance MariaDB en arrière-plan ss surveillance -> confid la bd
mariadbd-safe --nowatch &

# Vérifier que la bd est prête à accepter des connexions
while ! mariadb-check -A
do
    sleep 1
done

# Si la base de données et l'utilisateur n'existent pas déjà->creation
mariadb -e "CREATE DATABASE IF NOT EXISTS $MDB_NAME;"
mariadb -e "CREATE USER IF NOT EXISTS $MDB_USER@'localhost' IDENTIFIED BY '$MDB_PASS';"

# Attribution des privilèges à l'utilisateur sur la base de données
mariadb -e "GRANT ALL PRIVILEGES ON $MDB_NAME.* TO $MDB_USER@'%' IDENTIFIED BY '$MDB_PASS';"

# recharge les privileges -> changement immediat
mariadb -e "FLUSH PRIVILEGES;"

# Créer un mot de passe root pour sécuriser la base de données
# Définir le mot de passe root et arrêter le service MariaDB pour préparer l'environnement
mariadb-admin -u root password "$MDB_PASS"
mariadb-admin -u root -p"$MDB_PASS" shutdown

# creation du fichier pour conf que la config est un succes
touch /setup

# Lancer MariaDB en premier plan pour maintenir le container actif
mariadbd-safe
