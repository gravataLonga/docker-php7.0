FROM ubuntu:artful

# Set the env variable DEBIAN_FRONTEND to noninteractive
ENV DEBIAN_FRONTEND noninteractive

# Local time
ENV TIMEZONE_ENV Europe/Lisbon

# Change sources to a server in Portugal to make package download faster
RUN sed -i 's/http:\/\//http:\/\/pt./g' /etc/apt/sources.list

# Update and upgrade system if necessary
RUN apt-get update && apt-get -y upgrade && apt-get -y dist-upgrade

# PHP Installation
RUN apt-get -y install php7.1 php7.1-fpm php7.1-xml php7.1-gd php7.1-json php7.1-mbstring php7.1-soap php7.1-zip php7.1-opcache php7.1-mcrypt php7.1-curl php7.1-pgsql php7.1-mysql php7.1-intl php-xdebug php-redis php7.1-intl

# Overidden configuration files
COPY conf /

RUN echo $TIMEZONE_ENV > /etc/timezone
RUN echo "date.timezone=$TIMEZONE_ENV" > /etc/php/7.1/cli/conf.d/timezone.ini

RUN useradd application
WORKDIR /var/www

EXPOSE 9000
ENTRYPOINT ["php-fpm7.1", "--nodaemonize"]
