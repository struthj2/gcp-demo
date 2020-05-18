#!/bin/bash
+ex
echo "Build MySQL Container"
docker build ./docker/ -f ./docker/MySQL-Dockerfile -t mysql-demo

echo "Run MySQL DB Container"
docker run -d -p 3306:3306 -p 33060:33060--name mysql-demo -e MYSQL_ROOT_PASSWORD=supersecret mysql-demo

echo "Sleep 30 while DB initializing"
sleep 30

echo "Run Gradle"
./gradlew clean build run

# docker build -f ./docker/Gcp-fetcher-Dockerfile ./docker/ -t gcp-fetcher-jdk
# # run 
# docker run --net=my-network gcp-fetcher-jdk java -jar ./gcp-demo-all-1.0-SNAPSHOT.jar