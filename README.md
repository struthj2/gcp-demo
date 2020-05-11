# gcp-demo
This repo is for the purpose of trying out GCP including google cloud SDK, BigQuery, and DataProc with Spark. It mostly contains tutorial material from GCP as an introduction to the tools.

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




