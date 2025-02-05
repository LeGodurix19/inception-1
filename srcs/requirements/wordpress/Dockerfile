FROM debian:bullseye

# Install necessary dependencies
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

# Create required directories
RUN mkdir -p /run/php && chown -R www-data:www-data /run/php

# Create directory for WordPress
RUN mkdir -p /var/www/html

# Download and extract WordPress
RUN curl -O https://wordpress.org/latest.tar.gz && \
    tar -xzf latest.tar.gz && \
    rm latest.tar.gz && \
    mv wordpress/* /var/www/html/ && \
    rmdir wordpress

# Copy the wp-config generation script
COPY ./tools/wp-config.sh /usr/local/bin/wp-config.sh
RUN chmod +x /usr/local/bin/wp-config.sh

# Set proper permissions for WordPress files
RUN chown -R www-data:www-data /var/www/html && chmod -R 755 /var/www/html

# Expose the HTTP port
EXPOSE 80
#EXPOSE 443????

# Run wp-config.sh before starting PHP-FPM
CMD ["/bin/bash", "-c", "mkdir -p /run/php && chown -R www-data:www-data /run/php && /usr/local/bin/wp-config.sh && php-fpm7.4 -F"]

