FROM composer:1.10.1 as build

WORKDIR /app
COPY . /app
RUN composer install

FROM php:7.4-apache

EXPOSE 80
RUN echo "ServerName localhost" >> /etc/apache2/apache2.conf
COPY --from=build /app /app
COPY vhost.conf /etc/apache2/sites-available/000-default.conf
RUN chown -R www-data:www-data /app \
    && a2enmod rewrite
USER www-data