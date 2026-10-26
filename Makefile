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

fclean: clean
	@docker compose -f $(COMPOSE_FILE) down -v --rmi all 2>/dev/null || true
	@rm -rf $(DATA_DIR)/wordpress/* 2>/dev/null || true
	@rm -rf $(DATA_DIR)/mariadb/* 2>/dev/null || true

re: fclean all

.PHONY: all up down start stop status create_dirs clean fclean re
