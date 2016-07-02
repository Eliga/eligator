#!/bin/sh

docker run -i -d --privileged 						\
	-e "MYSQL_USER=root"							\
	-e "PHAB_URI=https://phab.eliga.io"				\
	-e "MYSQL_PASS=${MYSQL_PASS}"					\
	-p 8081:80 										\
	-v /home/eligator/mysql:/var/lib/mysql 			\
	zapaz/eligator:latest

#	-p 2244:22  									\
#	-v /home/eligator/conf:/opt/phabricator/conf 	\
#	-v /home/eligator/repo:/var/repo 				\

