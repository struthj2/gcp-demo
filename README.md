# gcp-demo
### Prerequistes
- [Google Cloud SDK (gsutil, bq, gcloud)](https://cloud.google.com/sdk/install)
- [Docker](https://www.docker.com/products/docker-desktop)
- JDK 1.8 

## Background
This repo is for the purpose of trying out GCP including google cloud SDK, BigQuery, and DataProc with Spark. It mostly contains [tutorial](#Awknowledgements) material from GCP as an introduction to the tools. This was created as exploritation of different tools in a tech stack.

__Additionally__ it contains an example of using streams with MySQL, and part of the [NPR Story API](https://www.npr.org/api/inputReference.php). 

(Eventually, the goal is to write the combined dataset to GCP. Currently they are not connected, repo is still a _work in progress_).

## Querying MySQL with ORM, Streams, and NPR API XML example

The `src` folder contains a gradle/java8 sub-project to pull records from the MySQL DB (using the mysql connector, and Hibernate ORM). 
- A util class fetches genre data from the NPR API as XML.
- Then a dataset of Users is fetched from the DB using the ORM.
- Streams are used to perform simple operations:
    - First listing the Users
    - Then, filtering on Users with a favorite genre matching one selected from the API.

The purpose of this demo was take a look at exising APIs NPR has availible, as well as imagine a use case that the CMS Story API and Public Media Platform (PMP) replacement platform might use.

### Running locally
Run the build script to build the MySQL docker container, and then run the java8 app.
```
./build.sh
```
or individually:
1. Build the MySQL Docker container with: 
```docker build ./docker/ -f ./docker/MySQL-Dockerfile -t mysql-demo```
2. Then run the container in the background:   
```docker run -d -p 3306:3306 -p 33060:33060 --name mysql-demo -e MYSQL_ROOT_PASSWORD=supersecret mysql-demo```
3. Run to verify the container is healthy (wait for database/innodb to finish initializing can take around 30 sec):  
```docker ps```
    1. e.g look to see or similar:
    ```
    STATUS
    Up About a minute (healthy)
    ```

4. Once the database container is up, run the java app:      
```./gradlew clean build run```

### Improvements
This was made as an explorative project before an interview. To acutally run an app or service like this a number of improvements could be made.

#### Use of an ORM vs direct DB acess 
ORMs can be a useful abstraction on top of RDBMS databases, however they can lead to [issues](https://martinfowler.com/bliki/OrmHate.html). Direct DB access can be more modular and simple in some cases, many things that can be done with an ORM can be done with a SQL query.

#### Interaction with NPR One API vs Story API
The NPR One API is well documented and seems to have ongoing support. In future iterations, if this was a sample app it could interact with the NPR One API or use the [javascript sdk](https://github.com/npr/npr-one-api-js-sdk).

#### XML parser
There are many XML parsers availible, if using the legacy API. SAX, JacksonXML or others could be good refactors.

## GCP Demo using Apache Spark and BigQuery.
Define a bucket with: 
```
gsutil mb gs://gcp-demo-spark-bucket
```
Launch `spark-shell` with the bq connector
```
spark-shell --jars=gs://spark-lib/bigquery/spark-bigquery-latest.jar
```
or use the following if running python:
```
gcloud dataproc jobs submit pyspark ./demo/wordcount.py \
    --cluster gcp-demo \
    --region us-west2 \
    --jars=gs://spark-lib/bigquery/spark-bigquery-latest.jar
```
```
spark-submit --jars gs://spark-lib/bigquery/spark-bigquery-latest.jar wordcount.py
```

### Awknowledgements 
- [BigQuery and DataProc Quick Start](https://cloud.google.com/dataproc/docs/quickstarts)
- [BigQuery Spark connector](https://cloud.google.com/dataproc/docs/tutorials/bigquery-connector-spark-example)
- [Hibernate ORM, HCL Intro](https://grokonez.com/hibernate/hibernate-query-language-hql-java-8-mysql)
- [XML parse from oracle](https://docs.oracle.com/cd/B28359_01/appdev.111/b28394/adx_j_parser.htm#CCHBEGDD)
- More [Hibernate](https://www.tutorialspoint.com/hibernate/hibernate_configuration.htm), [Hibernate, Streams 5.2](https://dzone.com/articles/streams-in-hibernate-and-beyond)


