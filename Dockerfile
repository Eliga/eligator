FROM tutum/lamp:latest
MAINTAINER Alain Papazoglou <alain@eliga.fr>

# Mise à jour
RUN apt-get update
RUN apt-get upgrade -y

# Alias  par defaut
COPY alias.txt /alias.txt
RUN cat /alias.txt >> /etc/bash.bashrc

# Install some packages
RUN apt-get install -y git wget php5-curl php5-gd ssmtp

# Supervisor
COPY supervisord.conf /etc/supervisor/conf.d/eligator.conf
RUN mkdir -p /var/log/supervisor
RUN rm /etc/supervisor/conf.d/supervisord-mysqld.conf

# Enabled mod rewrite for phabricator
RUN a2enmod rewrite

# Set password to 'admin'
RUN printf admin\\nadmin\\n | passwd

COPY ./startup.sh /opt/startup.sh
COPY ./update.sh /opt/update.sh
RUN chmod +x /opt/startup.sh
RUN chmod +x /opt/update.sh

COPY php.ini /etc/php5/apache2/conf.d/php.ini
COPY preamble.php /opt/preamble.php
COPY local.json /opt/local.json
COPY ssmtp.conf /opt/ssmtp.conf

COPY phabricator.conf /etc/apache2/sites-available/phabricator.conf
RUN rm -f /etc/apache2/sites-enabled/000-default.conf
RUN ln -s /etc/apache2/sites-available/phabricator.conf /etc/apache2/sites-enabled/phabricator.conf

RUN ulimit -c 10000

EXPOSE 80
CMD ["/usr/bin/supervisord"]
