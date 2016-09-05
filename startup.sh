#/bin/bash

cd /opt/
git clone git://github.com/facebook/libphutil.git
git clone git://github.com/facebook/arcanist.git
git clone git://github.com/facebook/phabricator.git

sed -e "s/{{HTTPS}}/${HTTPS}/g" \
    -i /opt/preamble.php
cp /opt/preamble.php /opt/phabricator/support/

sed -e "s/{{MYSQL_HOST}}/${MYSQL_HOST}/g" \
    -e "s/{{MYSQL_PORT}}/${MYSQL_PORT}/g" \
    -e "s/{{MYSQL_USER}}/${MYSQL_USER}/g" \
    -e "s/{{MYSQL_PASS}}/${MYSQL_PASS}/g" \
    -e "s/{{PHAB_URI}}/${PHAB_URI//\//\\/}/g" \
    -i /opt/local.json
cp /opt/local.json /opt/phabricator/conf/local/local.json

sed -e "s/{{SSMTP_EMAIL}}/${SSMTP_EMAIL}/g" \
    -e "s/{{SSMTP_SERVER}}/${SSMTP_SERVER}/g" \
    -e "s/{{SSMTP_PASS}}/${SSMTP_PASS}/g" \
    -e "s/{{PHAB_URI}}/${PHAB_URI//\//\\/}/g" \
    -i /opt/ssmtp.conf
cp /opt/ssmtp.conf /etc/ssmtp/ssmtp.conf

cd /opt/phabricator && ./bin/storage upgrade --force
cd /opt/phabricator && ./bin/phd restart

/bin/bash /opt/update.sh
