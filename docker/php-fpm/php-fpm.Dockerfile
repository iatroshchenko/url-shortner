FROM php:7.3-fpm

ADD ./default.ini /usr/local/etc/php/conf.d/default.ini

RUN apt-get update && \
    apt-get install -y \
        zlib1g-dev

RUN apt-get update && yes | apt-get install libzip-dev

RUN apt-get update && apt-get install -y \
        libfreetype6-dev \
        libjpeg62-turbo-dev \
        libpng-dev \
    && docker-php-ext-install -j$(nproc) iconv \
    && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
    && docker-php-ext-install -j$(nproc) gd

RUN apt-get update && docker-php-ext-install pdo pdo_mysql zip

RUN curl -sS https://getcomposer.org/installer | php -- \
        --filename=composer \
        --install-dir=/usr/local/bin

RUN apt-get update
RUN apt-get install -y \
        cron

RUN touch /var/log/schedule.log
RUN chmod 0777 /var/log/schedule.log

# Add crontab file in the cron directory
# ADD ./scheduler /etc/cron.d/scheduler

# Run the cron
# RUN crontab /etc/cron.d/scheduler
# CMD ["cron", "-f"]

WORKDIR /var/www/app
