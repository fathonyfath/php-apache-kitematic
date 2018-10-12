FROM webdevops/php-apache-dev:7.2

# Update apt-get
RUN apt-get update

# Enable htaccess
RUN a2enmod rewrite

# Plugin Install goes here

# Install PDO MySQL driver
RUN docker-php-ext-install pdo pdo_mysql

# Install PDO PostgreSQL driver
RUN apt-get install -y libpq-dev \
    && docker-php-ext-configure pgsql -with-pgsql=/usr/local/pgsql \
    && docker-php-ext-install pgsql pdo pdo_pgsql

# Install gd plugins
RUN apt-get update && apt-get install -y \
        libfreetype6-dev \
        libjpeg62-turbo-dev \
        libpng-dev \
    && docker-php-ext-install -j$(nproc) iconv \
    && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
    && docker-php-ext-install -j$(nproc) gd

# Removes apt caches
RUN apt-get clean autoclean && \
    apt-get autoremove --yes && \
    rm -rf /var/lib/{apt,dpkg,cache,log}/

VOLUME /app
