#!/bin/sh

docker run -i -d --privileged 						\
	-p 8081:80 										\
	-v /home/eligator/mysql:/var/lib/mysql 			\
	-e "MYSQL_USER=$MYSQL_USER"						\
	-e "MYSQL_PASS=$MYSQL_PASS"						\
	-e "PHAB_URI=$PHAB_URI"							\
	-e "SSMTP_SERVER=$SSMTP_SERVER"					\
	-e "SSMTP_EMAIL=$SSMTP_EMAIL"					\
	-e "SSMTP_PASS=$SSMTP_PASS"						\
	--link mysql:mysql 								\
	zapaz/eligator:latest

