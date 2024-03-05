FROM composer:2.6.6 as composer_build

WORKDIR /app
COPY . /app
RUN composer install --optimize-autoloader --ignore-platform-reqs --no-interaction --no-plugins --no-scripts --prefer-dist

FROM --platform=linux/amd64 php:8.1.17
COPY --from=composer_build /app/ /app/
WORKDIR /app
CMD php artisan serve --host=0.0.0.0 --port $PORT
EXPOSE $PORT