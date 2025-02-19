FROM debian:bullseye

# Installer les dépendances nécessaires
RUN apt-get update && apt-get install -y \
    curl \
    zip \
    unzip \
    php \
    php-mysqli \
    php-fpm \
    php-curl \
    php-zip \
    php-gd \
    php-mbstring \
    php-xml \
    php-xmlrpc \
    php-soap \
    php-intl \
    php-bcmath \
    php-imagick \
    && apt-get clean

# Créer les répertoires nécessaires
RUN mkdir -p /run/php /var/www/html \
    && chown -R www-data:www-data /run/php /var/www/html

# Télécharger et installer WordPress
RUN curl -O https://wordpress.org/latest.tar.gz && \
    tar -xzf latest.tar.gz && \
    rm latest.tar.gz && \
    mv wordpress/* /var/www/html/ && \
    rmdir wordpress

# Copier le script de configuration automatique de WordPress
COPY ./tools/wp-config.sh /usr/local/bin/wp-config.sh
RUN chmod +x /usr/local/bin/wp-config.sh

# Copier le fichier de configuration PHP-FPM
COPY ./tools/www.conf /etc/php/7.4/fpm/pool.d/www.conf

# Donner les bonnes permissions aux fichiers WordPress
RUN chown -R www-data:www-data /var/www/html && chmod -R 755 /var/www/html

# Exposer le port utilisé par PHP-FPM
EXPOSE 9000

# Lancer PHP-FPM en foreground et générer le wp-config au démarrage
CMD ["/bin/bash", "-c", "/usr/local/bin/wp-config.sh && php-fpm7.4 -F"]
