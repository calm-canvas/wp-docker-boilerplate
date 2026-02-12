FROM wordpress:6.9.0-php8.3-apache

# Keep ARG and RUN logic to map your UID/GID
ARG WWWUSER=1000
ARG WWWGROUP=1000

RUN if [ ${WWWUSER} -ne 33 ]; then \
        EXISTING_USER=$(getent passwd ${WWWUSER} | cut -d: -f1); \
        if [ ! -z "$EXISTING_USER" ]; then userdel -f $EXISTING_USER; fi; \
        usermod -u ${WWWUSER} www-data; \
    fi && \
    if [ ${WWWGROUP} -ne 33 ]; then \
        EXISTING_GROUP=$(getent group ${WWWGROUP} | cut -d: -f1); \
        if [ ! -z "$EXISTING_GROUP" ]; then groupdel $EXISTING_GROUP; fi; \
        groupmod -g ${WWWGROUP} www-data; \
    fi

RUN apt-get update && apt-get install -y \
    curl nano git tzdata \
    $PHPIZE_DEPS \
    && pecl install xdebug \
    && docker-php-ext-enable xdebug \
    && ln -snf /usr/share/zoneinfo/Asia/Ho_Chi_Minh /etc/localtime && echo Asia/Ho_Chi_Minh > /etc/timezone \
    && rm -rf /var/lib/apt/lists/*

# Copy Composer [cite: 1]
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

ENV COMPOSER_ALLOW_SUPERUSER=1

# Ensure permissions on the home directory of www-data
RUN chown -R www-data:www-data /var/www