# Utiliza una imagen oficial de PHP como base
FROM php:8.1-fpm

# Instala las extensiones PHP necesarias
RUN apt-get update && apt-get install -y \
    libzip-dev \
    zip \
    unzip \
  && docker-php-ext-install zip

# Instala Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Copia el código fuente de tu aplicación
COPY . /var/www/html

# Cambia al directorio de trabajo
WORKDIR /var/www/html

RUN chmod -R 775 storage/ bootstrap/cache/
RUN php -r "file_exists('.env') || copy('.env.example', '.env');"
RUN php artisan key:generate

# Expone el puerto 8000 para servir la aplicación
EXPOSE 8000

# Comando para iniciar la aplicación Laravel
CMD php artisan serve --host=0.0.0.0 --port=8000
