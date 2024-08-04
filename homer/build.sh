#!/bin/bash

docker-compose up -d
wget --mirror -p --convert-links -P ./dist http://localhost:8080
cp -rf ./theme/assets/* ./dist/localhost:8080/assets/
docker-compose stop

rsync -avzhe ssh ./dist/localhost\:8080/* u71891509@home450438325.1and1-data.host:/kunden/homepages/7/d450438325/htdocs/sites/hi.honeymachine.io