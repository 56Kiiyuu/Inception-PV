NAME = inception

SRCS_DIR = srcs
COMPOSE_FILE = $(SRCS_DIR)/docker-compose.yml
#vu que je work sur SSD
DATA_DIR = $(HOME)/data

all: up

up: create_dirs
	docker compose -f $(COMPOSE_FILE) up -d --build

down:
	docker compose -f $(COMPOSE_FILE) down

start:
	docker compose -f $(COMPOSE_FILE) start

stop:
	docker compose -f $(COMPOSE_FILE) stop

status:
	docker compose -f $(COMPOSE_FILE) ps

create_dirs:
	@mkdir -p $(DATA_DIR)/wordpress
	@mkdir -p $(DATA_DIR)/mariadb

clean: down
	@docker system prune -a --force

fclean: clean
	@docker run --rm -v $(DATA_DIR):/data debian:bookworm rm -rf /data/wordpress/* /data/mariadb/* 2>/dev/null || true
	@rm -rf $(DATA_DIR)/wordpress/* 2>/dev/null || true
	@rm -rf $(DATA_DIR)/mariadb/* 2>/dev/null || true
	@docker volume rm $$(docker volume ls -q) 2>/dev/null || true

re: fclean all

.PHONY: all up down start stop status create_dirs clean fclean re
