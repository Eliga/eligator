#!/bin/sh

docker run -i -d --privileged 						\
	-p 8081:80 										\
	-v /home/eligator/mysql:/var/lib/mysql 			\
	zapaz/eligator:latest

#	-p 2244:22  									\
#	-v /home/eligator/conf:/opt/phabricator/conf 	\
#	-v /home/eligator/repo:/var/repo 			\

