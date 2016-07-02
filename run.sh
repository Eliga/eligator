#!/bin/sh

docker run -i -d --privileged 						\
	-p 8081:80 										\
	-v /home/eligator/mysql:/var/lib/mysql 			\
	-e "MYSQL_USER=$MYSQL_USER"						\
	-e "MYSQL_PASS=$MYSQL_PASS"						\
	-e "PHAB_URI=$PHAB_URI"							\
	-e "MYSQL_USER=$MYSQL_USER"						\
	-e "MYSQL_PASS=$MYSQL_PASS"						\
	-e "PHAB_URI=$PHAB_URI"							\
	zapaz/eligator:latest

