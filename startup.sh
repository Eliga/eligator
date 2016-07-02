#/bin/bash

if [ ! -f /var/lib/mysql/ibdata1 ]; then

	echo "init Mysql admin user"
	killall mysqld

	mysql_install_db

	mysqld_safe &
	sleep 10s

	echo "GRANT ALL ON *.* TO admin@'%' IDENTIFIED BY 'admin' WITH GRANT OPTION; FLUSH PRIVILEGES" | mysql
fi

cd /opt/
git clone git://github.com/facebook/libphutil.git
git clone git://github.com/facebook/arcanist.git
git clone git://github.com/facebook/phabricator.git

chmod 666 /opt/phabricator/conf/local/local.json

# if container restart, fix mysql rights
chown -R mysql:mysql /var/lib/mysql

/opt/phabricator/bin/config set mysql.user ${MYSQL_USER}
/opt/phabricator/bin/config set mysql.pass ${MYSQL_PASS}
/opt/phabricator/bin/config set phabricator.base-uri ${PHAB_URI}

#sed -e "s/{{MYSQL_USER}}/${MYSQL_USER}/g" \
#    -e "s/{{MYSQL_PASS}}/${MYSQL_PASS}/g" \
#    -e "s/{{PHAB_URI}}/${PHAB_URI}/g" \
#    -i /opt/phabricator/conf/local/local.json

cd /opt/phabricator && ./bin/storage upgrade --force
cd /opt/phabricator && ./bin/phd restart

/bin/bash /opt/update.sh

