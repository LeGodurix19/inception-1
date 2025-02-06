FROM debian:bullseye

# Installez MariaDB
RUN apt-get update && apt-get install -y mariadb-server && rm -rf /var/lib/apt/lists/*

# Exposez le port 3306 pour MariaDB
EXPOSE 3306

# Assurez-vous que MariaDB a les bonnes permissions
RUN mkdir -p /var/run/mysqld && chown -R mysql:mysql /var/run/mysqld && chmod -R 755 /var/lib/mysql

# Copiez le script d'initialisation
COPY ./tools/init.sh /usr/local/bin/init.sh
RUN chmod +x /usr/local/bin/init.sh

# Commande pour démarrer MariaDB et exécuter le script de configuration
ENTRYPOINT ["/usr/local/bin/init.sh"]
