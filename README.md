Eligator
==================
Eliga specific version of Phabricator


Dockerfile
----------
Derived form old version of yesnault/docker-phabricator
With Ubuntu, Apache and MySQL

Data Volume :
- mysql : /var/lib/mysql => /home/eligator/mysql

Exposed Port :
- 80 => 8081


Build Container
---------------
./build.sh


Run Container
-------------
export MYSQL_USER="user"
export MYSQL_PASS="password"
export PHAB_URI="http://phab.uri:8081"

./run.sh



Run Eligator
---------------

Go to http://phab.uri:8081

