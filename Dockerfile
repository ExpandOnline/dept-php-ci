FROM php:7.1.13

RUN apt-get update && \
    apt-get install -y python git unzip curl libmcrypt-dev zlib1g-dev libxml2-dev libicu-dev \
    && apt-get clean && apt-get autoremove \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN docker-php-ext-install zip pdo pdo_mysql mcrypt soap bcmath pcntl sockets intl

RUN pecl install -o -f redis \
&&  rm -rf /tmp/pear \
&&  docker-php-ext-enable redis

RUN apt-get update && apt-get install -y libssl-dev && rm -rf /var/lib/apt/lists/*
RUN pecl install mongodb-1.3.4 \
    && docker-php-ext-enable mongodb

# Install Composer and make it available in the PATH
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/bin/ --filename=composer

#RUN SYMFONY_ENV=test composer install --no-interaction

RUN mkdir /root/.ssh && ssh-keyscan github.com >> /root/.ssh/known_hosts

RUN echo "Europe/Amsterdam" > /etc/timezone && dpkg-reconfigure --frontend noninteractive tzdata


LABEL "com.github.actions.name"="PHP CI"
LABEL "com.github.actions.description"="Build or test composer projects"
LABEL "com.github.actions.icon"="mic"
LABEL "com.github.actions.color"="purple"

LABEL "repository"="http://github.com/expandonline/dept-php-ci"
LABEL "homepage"="http://github.com/actions"
LABEL "maintainer"="Peter Vaassens <peter.vaassens@deptagency.com>"
