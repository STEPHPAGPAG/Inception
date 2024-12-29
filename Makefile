# s'exécute avec make : creation de repert mysql+wordpr + lance docker conp + construit les images
all:
	mkdir -p /home/spagliar/data/mysql /home/spagliar/data/wordpress
	docker compose -f ./srcs/docker-compose.yml up -d --build

# redemarre sans reconstruire les images (up -d)
up:
	docker compose -f ./srcs/docker-compose.yml up -d

# Arrête et supprime les containers, réseaux, volumes (down)
down:
	docker compose -f ./srcs/docker-compose.yml down

# pour tout nettoyer et supprimer (volumes, mysql et fichiers temporaires)
fclean: down
	docker system prune -fa --volumes
	sudo rm -rf /home/spagliar/data/mariadb/*
	sudo rm -rf /home/spagliar/data/wordpress/*

# pour effectuer un nettoyage complet (fclean) et relancer l'ensemble du processus (all)
re: fclean all
