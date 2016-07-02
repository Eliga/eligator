FROM tutum/lamp:latest
MAINTAINER Alain Papazoglou <alain@eliga.fr>

# Mise à jour
RUN apt-get update
RUN apt-get upgrade -y

# Alias  par defaut
ADD alias.txt /alias.txt
RUN cat /alias.txt >> /etc/bash.bashrc

# Git to retreive phabricator source
RUN apt-get install -y git ssh wget
RUN mkdir /var/run/sshd

# Supervisor
RUN apt-get install -y supervisor
ADD supervisord.conf /etc/supervisor/conf.d/supervisord.conf
RUN mkdir -p /var/log/supervisor

# Enabled mod rewrite for phabricator
RUN a2enmod rewrite
 
RUN sed -i -e"s/^bind-address\s*=\s*127.0.0.1/bind-address = 0.0.0.0/" /etc/mysql/my.cnf

# Set password to 'admin'
RUN printf admin\\nadmin\\n | passwd
 
ADD ./startup.sh /opt/startup.sh
ADD ./update.sh /opt/update.sh
RUN chmod +x /opt/startup.sh
RUN chmod +x /opt/update.sh

ADD phabricator.conf /etc/apache2/sites-available/phabricator.conf
RUN ln -s /etc/apache2/sites-available/phabricator.conf /etc/apache2/sites-enabled/phabricator.conf
RUN rm -f /etc/apache2/sites-enabled/000-default

RUN ulimit -c 10000
 
EXPOSE 3306 80 22

CMD ["/usr/bin/supervisord"] 

