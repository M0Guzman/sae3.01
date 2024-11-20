FROM php:8.2

RUN apt-get update -y && apt-get install -y openssl zip unzip git libpq-dev libonig-dev nodejs npm
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer
RUN docker-php-ext-install pgsql pdo_pgsql pdo mbstring

WORKDIR /app
COPY . /app
RUN composer install
RUN npm install
RUN npm run build

CMD php artisan serve --host=0.0.0.0 --port=8181
EXPOSE 8181
