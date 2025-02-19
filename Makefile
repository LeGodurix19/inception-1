all:
	
	cd srcs && docker compose -f docker-compose.yml up --build -d
	sudo echo "127.0.0.1 example.com" >> /etc/hosts
	sudo echo "127.0.0.1 www.example.com" >> /etc/hosts

clean:
	
	cd srcs && docker compose -f docker-compose.yml down

fclean: clean
	docker system prune --volumes --force
	rm -rf srcs/data

re: fclean all

.PHONY: all clean fclean re
