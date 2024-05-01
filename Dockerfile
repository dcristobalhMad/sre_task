# Use an official PHP image as the base image
FROM php:8.3.7RC1-zts-alpine

# Set the working directory inside the container
WORKDIR /var/www/html

# Copy the code, config, public, and src directories into the container
COPY code /var/www/html
COPY code/config /var/www/html/config
COPY code/public /var/www/html/public
COPY code/src /var/www/html/src

# Install dependencies and necessary tools
RUN apk update && \
    apk add --no-cache unzip curl && \
    apk add --no-cache $PHPIZE_DEPS && \
    docker-php-ext-install pdo_mysql && \
    apk add --no-cache libmemcached-dev zlib-dev && \
    pecl install memcached && \
    docker-php-ext-enable memcached && \
    curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer && \
    composer update && \
    composer install && \
    apk del unzip curl $PHPIZE_DEPS && \
    rm -rf /var/cache/apk/*

# Expose port 80 for web server
EXPOSE 80

# Start PHP web server
CMD ["php", "-S", "0.0.0.0:80", "-t", "/var/www/html/public"]