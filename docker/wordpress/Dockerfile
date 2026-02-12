FROM wordpress:6.9.0-php8.3-apache

# Environment settings
ARG WWWUSER=1000
ARG WWWGROUP=1000
ARG TZ=Asia/Ho_Chi_Minh

# Map UID/GID and install dependencies
RUN if [ ${WWWUSER} -ne 33 ]; then \
        EXISTING_USER=$(getent passwd ${WWWUSER} | cut -d: -f1); \
        if [ ! -z "$EXISTING_USER" ]; then userdel -f $EXISTING_USER; fi; \
        usermod -u ${WWWUSER} www-data; \
    fi && \
    if [ ${WWWGROUP} -ne 33 ]; then \
        EXISTING_GROUP=$(getent group ${WWWGROUP} | cut -d: -f1); \
        if [ ! -z "$EXISTING_GROUP" ]; then groupdel $EXISTING_GROUP; fi; \
        groupmod -g ${WWWGROUP} www-data; \
    fi && \
    apt-get update && apt-get install -y \
    curl nano git tzdata zip unzip \
    $PHPIZE_DEPS \
    && pecl install xdebug \
    && docker-php-ext-enable xdebug \
    && ln -snf /usr/share/zoneinfo/${TZ} /etc/localtime && echo ${TZ} > /etc/timezone \
    && apt-get purge -y --auto-remove -o APT::AutoRemove::RecommendsImportant=false \
    && rm -rf /var/lib/apt/lists/* /tmp/pear

# Copy Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

ENV COMPOSER_ALLOW_SUPERUSER=1

# Ensure permissions on the home directory of www-data
RUN chown -R www-data:www-data /var/www
