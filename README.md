Eligator
==================
Eliga specific version of Phabricator


Dockerfile
----------
Derived form old version of yesnault/docker-phabricator
With Ubuntu, Apache and MySQL

3 volumes :
- conf	: /opt/phabricator/conf	map to host  /home/eligator/conf
- Mysql : /var/lib/Mysql 		map to host  /home/eligator/mysql
- repo	: /var/repo				map to host  /home/eligator/repo

2 ports :
- 80 map to host 8081
- 22 map to host 2244


Build Container
---------------
./build.sh


Run Container
-------------
./run.sh


Configure
---------
To configure password and domain 

docker exec -it <containerID> /opt/phabricator/bin/config set mysql.pass <Password Mysql>
docker exec -it <containerID> /opt/phabricator/bin/config set mysql.pass <Your Domain>


Run Eligator
---------------

Go to http://your.domain:8081

