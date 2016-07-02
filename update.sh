#!/bin/bash

cd /opt/libphutil && git pull
cd /opt/arcanist && git pull
cd /opt/phabricator && git pull

cd /opt/phabricator && ./bin/storage upgrade --force
cd /opt/phabricator && ./bin/phd restart
