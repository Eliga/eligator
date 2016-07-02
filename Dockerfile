FROM tutum/lamp:latest
MAINTAINER Alain Papazoglou <alain@eliga.fr>

# Mise à jour
RUN apt-get update
RUN apt-get upgrade -y

# Alias  par defaut
COPY alias.txt /alias.txt
RUN cat /alias.txt >> /etc/bash.bashrc

# Git to retreive phabricator source
RUN apt-get install -y git wget

# Supervisor
COPY supervisord.conf /etc/supervisor/conf.d/eligator.conf
RUN mkdir -p /var/log/supervisor

# Enabled mod rewrite for phabricator
RUN a2enmod rewrite
 
RUN sed -i -e"s/^bind-address\s*=\s*127.0.0.1/bind-address = 0.0.0.0/" /etc/mysql/my.cnf

# Set password to 'admin'
RUN printf admin\\nadmin\\n | passwd
 
COPY ./startup.sh /opt/startup.sh
COPY ./update.sh /opt/update.sh
RUN chmod +x /opt/startup.sh
RUN chmod +x /opt/update.sh

COPY local.json /opt/local.json

COPY phabricator.conf /etc/apache2/sites-available/phabricator.conf
RUN rm -f /etc/apache2/sites-enabled/000-default
RUN ln -s /etc/apache2/sites-available/phabricator.conf /etc/apache2/sites-enabled/phabricator.conf

RUN ulimit -c 10000
 
VOLUME ["/var/lib/mysql"]
EXPOSE 80
CMD ["/usr/bin/supervisord"] 

