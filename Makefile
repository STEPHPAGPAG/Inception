NAME = inception
SRCS = ./srcs/
COMPOSE = ./srcs/docker-compose.yml

all: conf up

conf:
	@cp ./.env ./srcs/
	@echo "Creating volumes...\n"
	@mkdir -p /home/spagliar/data/mariadb-volume /home/spagliar/data/wordpress-volume
	@sudo sed -i '/^127.0.0.1/ {/spagliar.42.fr/! s/localhost/localhost spagliar.42.fr/}' /etc/hosts
	@echo "\n"
	@echo "Starting docker compose up..."

up:
	docker compose -p $(NAME) -f $(COMPOSE) up --build -d

down:
	docker compose -p $(NAME) down --volumes

start:
	docker compose -p $(NAME) start

stop:
	docker compose -p $(NAME) stop

clean-images:
	docker rmi -f $$(docker images -q) || true

clean: down clean-images

fclean: clean
	@sudo rm -rf /home/spagliar/data
	@docker system prune

re: fclean conf up