FROM ghcr.io/glpi-project/glpi-development-env:latest

USER root

# Workaround to make apache use same UID/GID as host user.
ARG HOST_GROUP_ID=1000
RUN groupmod --gid ${HOST_GROUP_ID} www-data
ARG HOST_USER_ID=1000
RUN usermod --uid ${HOST_USER_ID} www-data

# Allow login as www-data user and allow it to execute sudo
RUN usermod --shell /bin/bash www-data
RUN echo "www-data ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

# Make www-data user home persistent for cache purpose.
RUN mkdir --parents /home/www-data \
  && chown www-data:www-data /home/www-data \
  && usermod --home /home/www-data www-data
VOLUME /home/www-data

# Set the correct DocumentRoot for GLPI
RUN echo "DocumentRoot /var/www/html" >> /etc/apache2/sites-available/000-default.conf

# Set the ServerName to avoid the warning
RUN echo "ServerName localhost" >> /etc/apache2/apache2.conf

# Ensure the GLPI files are copied to the correct directory
COPY . /var/www/html/

# Change the working directory to /var/www/html
WORKDIR /var/www/html

# Expose port for Apache
EXPOSE 80

USER www-data
