#/bin/bash

cd /opt/
git clone git://github.com/facebook/libphutil.git
git clone git://github.com/facebook/arcanist.git
git clone git://github.com/facebook/phabricator.git

sed -e "s/{{HTTPS}}/${HTTPS}/g" -i /opt/preamble.php
cp /opt/preamble.php /opt/phabricator/support/

/opt/phabricator/bin/config set mysql.host ${MYSQL_HOST}
/opt/phabricator/bin/config set mysql.port ${MYSQL_PORT}
/opt/phabricator/bin/config set mysql.user ${MYSQL_USER}
/opt/phabricator/bin/config set mysql.pass ${MYSQL_PASS}
/opt/phabricator/bin/config set phabricator.base-uri ${PHAB_URI}

sed -e "s/{{SSMTP_EMAIL}}/${SSMTP_EMAIL}/g" \
    -e "s/{{SSMTP_SERVER}}/${SSMTP_SERVER}/g" \
    -e "s/{{SSMTP_PASS}}/${SSMTP_PASS}/g" \
    -e "s/{{PHAB_URI}}/${PHAB_URI//\//\\/}/g" \
    -i /etc/ssmtp/ssmtp.conf

cd /opt/phabricator && ./bin/storage upgrade --force
cd /opt/phabricator && ./bin/phd restart

/bin/bash /opt/update.sh
