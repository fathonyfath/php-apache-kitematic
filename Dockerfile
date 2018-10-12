FROM webdevops/php-apache-dev:7.2

# Enable htaccess
RUN a2enmod rewrite

# Plugin Install goes here

# Install PDO, mysql, and pgsql driver
RUN docker-php-ext-install mysql pgsql pdo pdo_mysql pdo_pgsql

# Install gd plugins
RUN apt-get update && apt-get install -y \
        libfreetype6-dev \
        libjpeg62-turbo-dev \
        libmcrypt-dev \
        libpng12-dev \
    && docker-php-ext-install -j$(nproc) iconv mcrypt \
    && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
    && docker-php-ext-install -j$(nproc) gd

VOLUME /app
