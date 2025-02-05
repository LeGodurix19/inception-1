all:
	mkdir -p /home/caymard/data/wordpress
	mkdir -p /home/caymard/data/mysql

	docker compose -f ./srcs/docker-compose.yml up --build -d

clean:
	docker compose -f srcs/docker-compose.yml down

fclean: clean
	docker system prune --volumes --force
	rm -rf /home/caymard/data

re: fclean all

.PHONY: all clean fclean re
