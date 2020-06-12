# gcp-demo
### Prerequistes
- [Google Cloud SDK (gsutil, bq, gcloud)](https://cloud.google.com/sdk/install)
- [Docker](https://www.docker.com/products/docker-desktop)
- [docker-compose](https://docs.docker.com/compose/install/#install-using-pip)
    - ```pip install docker-compose```
- JDK 1.8 

## Background
This repo is for the purpose of trying out GCP including google cloud SDK, BigQuery, and DataProc with Spark. It mostly contains [tutorial](#Awknowledgements) material from GCP as an introduction to the tools. This was created as exploritation of different tools in a tech stack.

__Additionally__ it contains an example of using streams with MySQL, and part of the [NPR Story API](https://www.npr.org/api/inputReference.php). 

(Eventually, the goal is to write the combined dataset to GCP. Currently they are not connected, repo is still a _work in progress_).

## Querying MySQL with ORM, Streams, and NPR API XML example

The `src` folder contains a gradle/java8 sub-project to pull records from the MySQL DB (using the mysql connector, and Hibernate ORM) in a docker stack using compose.

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
1. Build and stage the the Java app with gradle:      
```
./gradlew clean fatJar prepareEnvironment
```
2. Then start the docker stack: building the MySQL container, Java container and bringing up the environment:   
```
docker-compose -f ./docker/docker-compose.yml up --build
```
3. The database will initialize by loading the init SQL script (InnoDB and startup will take a minute), then the Java container will check for the DB to be [healthy](https://docs.docker.com/compose/startup-order/) before starting the app.

### Improvements
This was made as an explorative project before an interview. To acutally run an app or service like this a number of improvements could be made.

#### Use of an ORM vs direct DB acess 
ORMs can be a useful abstraction on top of RDBMS databases, however they can lead to [issues](https://martinfowler.com/bliki/OrmHate.html). Direct DB access can be more modular and simple in some cases, many things that can be done with an ORM can be done with a SQL query.

#### Interaction with NPR One API vs Story API
The NPR One API is well documented and seems to have ongoing support. In future iterations, if this was a sample app it could interact with the NPR One API or use the [javascript sdk](https://github.com/npr/npr-one-api-js-sdk).

#### XML parser
There are many XML parsers availible, if using the legacy API. SAX, JacksonXML or others could be good refactors.

#### API Client
If this were a production app, it would be good to generalize the api client for multiple routes in the Story API. Also if pulling static content from that API, it could be useful to make and cache those requests, if the underlying data isn't subject to frequent change.

### Integration with brightspot CMS
To integrate this project with [`brightspot-cms`](https://github.com/perfectsense/brightspot-cms) (the CMS to potentially be used in the NPR platform) a few things could be done in future iterations. 
1. Replace the Hibernate ORM, with [Dari](https://github.com/perfectsense/dari) the data modeling framework used in brightspot. 
2. Make the existing MySQL instance comptible with brightspot/Dari. Dari has it's own DDL (See the DDL [here](https://github.com/perfectsense/dari/blob/release/3.2/db/src/main/resources/mysql/schema-12.sql)) that is used to make database versions compatible across vendors, also loads table schemas. 
3. Update exiting models classes to use dari. Note that dari doesn't store like Hibernate/ORMs where a class is mapped to a table. Dari will store them in the `Record` table serializing the object as json and storing it in a blob.
    1. In this example project we would extend the `Content` class provided by brightspot to implement this.

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
- [Brightspot, Dari docs](http://docs.brightspot.com/dari/data-modeling/indexes.html)


