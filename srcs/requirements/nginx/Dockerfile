FROM debian:bullseye

# Installez openssl
RUN apt-get update && apt-get install -y \
    openssl \
    nginx

# Créez le répertoire pour les certificats SSL et générez-les
RUN mkdir -p /etc/nginx/ssl && \
    openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
    -keyout /etc/nginx/ssl/nginx-selfsigned.key \
    -out /etc/nginx/ssl/nginx-selfsigned.crt \
    -subj "/CN=localhost"

# Copiez la configuration nginx
COPY ./conf/nginx.conf /etc/nginx/nginx.conf

# Exposez le port 443 pour HTTPS
EXPOSE 443

# Commande pour démarrer nginx
CMD ["nginx", "-g", "daemon off;"]
