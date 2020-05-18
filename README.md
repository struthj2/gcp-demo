# gcp-demo
This repo is for the purpose of trying out GCP including google cloud SDK, BigQuery, and DataProc with Spark. It mostly contains [tutorial](#Awknowledgements) material from GCP as an introduction to the tools.

_Additionally_ it contains an example of using streams with MySQL, and part of the NPR Storybook API. 

(Eventually, the goal is to write the combined dataset to GCP. Currently they are not connected).

The `gcp-fetcher` folder contains a gradle/java8 sub-project to pull records from the MySQL DB (using the mysql connector, and Hibernate ORM). A util class fetches genre data from the NPR API as XML. Then streams are used to perform simple operations.

The purpose of this demo was take a look at exising APIs NPR has availible, as well as imagine a use case that the CMS Storybook and Public Media Platform (PMP) replacement platform might use.


### Improvements
#### Use of an ORM vs direct DB acess 
ORMs are an excellent and useful abstraction on top of databases, however they can lead to issues. Direct DB access can be more modular and simple in some cases, many things that can be done with an ORM can be done with a SQL query.

#### Interaction with NPR One API vs StoryBook API
The NPR One API is well documented and seems to have ongoing support. In future iterations, if this was a sample app it could interact with the NPR One API or use the [javascript sdk](https://github.com/npr/npr-one-api-js-sdk).

### XML parser
There are many XML parsers availible, if using the legacy API. SAX, JacksonXML or others could be good refactors.

### Prerequistes
- [Google Cloud SDK (gsutil, bq, gcloud)](https://cloud.google.com/sdk/install)

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



