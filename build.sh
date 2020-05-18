#! /bin/bash
docker build ./docker/ -f ./docker/MySQL-Dockerfile -t mysql-demo

docker run -d -p 3306:3306 -p 33060:33060 --name mysql-demo -e MYSQL_ROOT_PASSWORD=supersecret mysql-demo