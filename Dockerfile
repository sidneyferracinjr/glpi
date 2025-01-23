# Use uma imagem base com Apache e PHP
FROM php:8.1-apache

# Instalar extensões necessárias para PostgreSQL
RUN apt-get update && apt-get install -y \
    libpq-dev libpng-dev libjpeg-dev libfreetype6-dev libxml2-dev \
    zip unzip wget libonig-dev \
    && docker-php-ext-install pgsql pdo_pgsql gd mbstring opcache \
    && docker-php-ext-configure gd --with-freetype --with-jpeg

# Configurar o timezone
RUN echo "date.timezone=UTC" > /usr/local/etc/php/conf.d/timezone.ini

# Copiar os arquivos do GLPI para o servidor
COPY . /var/www/html/

# Configurar permissões
RUN chown -R www-data:www-data /var/www/html \
    && chmod -R 755 /var/www/html

# Expor a porta 80 para o Apache
EXPOSE 80

# Comando para iniciar o Apache
CMD ["apache2-foreground"]
