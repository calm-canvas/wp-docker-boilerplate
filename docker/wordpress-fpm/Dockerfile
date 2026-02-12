FROM wordpress:6.9.0-fpm-alpine

# Install necessary extensions for WordPress & Cache
RUN apk add --no-cache \
    libpng-dev \
    libjpeg-turbo-dev \
    freetype-dev \
    libzip-dev \
    icu-dev \
    libxml2-dev \
    oniguruma-dev \
    shadow \
    $PHPIZE_DEPS \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install -j$(nproc) \
        gd \
        mysqli \
        pdo_mysql \
        zip \
        opcache \
        intl \
        bcmath \
        exif \
        soap \
    && pecl install redis \
    && docker-php-ext-enable redis \
    && apk del $PHPIZE_DEPS

ARG WWWUSER=1000
ARG WWWGROUP=1000

RUN if [ ${WWWUSER} -ne 82 ]; then \
        EXISTING_USER=$(getent passwd ${WWWUSER} | cut -d: -f1); \
        if [ ! -z "$EXISTING_USER" ]; then userdel -f $EXISTING_USER; fi; \
        usermod -u ${WWWUSER} www-data; \
    fi && \
    if [ ${WWWGROUP} -ne 82 ]; then \
        EXISTING_GROUP=$(getent group ${WWWGROUP} | cut -d: -f1); \
        if [ ! -z "$EXISTING_GROUP" ]; then groupdel $EXISTING_GROUP; fi; \
        groupmod -g ${WWWGROUP} www-data; \
    fi && \
    apk del shadow

WORKDIR /var/www/html

# Ensure permissions on the home directory of www-data
RUN chown -R www-data:www-data /var/www
