#!/usr/bin/env sh

# Wait for DB to come up
./wait
# Run java app
java -jar ./gcp-demo-all-1.0-SNAPSHOT.jar