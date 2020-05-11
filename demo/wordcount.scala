/*
 * Remove comment if you are not running in spark-shell.
 */
// import org.apache.spark.sql.SparkSession
// val spark = SparkSession.builder()
//   .appName("spark-bigquery-demo")
//   .getOrCreate()

val bucket = "gcp-demo-bucket"
spark.conf.set("temporaryGcsBucket", bucket)

// Load data in from BigQuery.
val wordsDF = spark.read.format("bigquery")
  .option("table","publicdata.samples.shakespeare")
  .load()
  .cache()
wordsDF.createOrReplaceTempView("words")

// Perform word count.
val wordCountDF = spark.sql(
  "SELECT word, SUM(word_count) AS word_count FROM words GROUP BY word")
wordCountDF.show()
wordCountDF.printSchema()

// Saving the data to BigQuery.
wordCountDF.write.format("bigquery")
  .option("table","wordcount_dataset.wordcount_output")
  .save()
