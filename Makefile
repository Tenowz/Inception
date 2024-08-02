up:
	mkdir -p /root/data/mariadb
	mkdir -p /root/data/wordpress
	docker-compose -f srcs/docker-compose.yml up -d --build

clean:
	docker-compose -f srcs/docker-compose.yml down

fclean: clean
	sudo rm -rf /root/data
	docker volume rm srcs_mariadb srcs_wordpress

re: clean up

logs:
	docker-compose -f srcs/docker-compose.yml logs -f

.PHONY: up down logs