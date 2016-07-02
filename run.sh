#!/bin/sh

docker run -i -d --privileged 						\
	-p 8081:80 										\
	-p 2244:22  									\
	-v /home/eligator/conf:/opt/phabricator/conf 	\
	-v /home/eligator/mysql:/var/lib/mysql 			\
	-v /home/eligator/repo:/var/repo 			\
	zapaz/eligator:latest

