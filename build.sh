#!/bin/bash
set -ex

echo "Run Gradle"
./gradlew clean fatJar prepareEnvironment

echo "Build MySQL Container and Java container, bring up docker env"
docker-compose -f ./docker/docker-compose.yml up --build

# echo "Build MySQL Container"
# docker build ./docker/ -f ./docker/MySQL-Dockerfile -t mysql-demo

# echo "Run MySQL DB Container"
# docker run -d -p 3306:3306 -p 33060:33060--name mysql-demo -e MYSQL_ROOT_PASSWORD=waitwaitdonttellme mysql-demo