# PySpark UDF / UDAF OOM

Out of memory exceptions with Python user-defined-functions are especially likely as Spark doesn't do a good job of managing memory between the JVM and Python VM. Together this can result in [exceeding container memory limits](../container-oom).



## Grouped Map / Co-Grouped

The `Grouped` & `Co-Grouped` UDFs are especially likely to cause out-of-memory exceptions in PySpark when combined with [key skew](key-skew).
Unlike most built in Spark aggregations, PySpark user-defined-aggregates *do not* support partial aggregation. This means that all of the data for a single key *must* fit in memory. If possible try and use an equivelent built-in aggregation, write a Scala aggregation supporting partial aggregates, or switch to an RDD and use `reduceByKey`.


This limitation applies regardless of if you are doing Arrow or "vanilla" UDAFs.



## Arrow / Pandas / Vectorized UDFS

If you are using PySpark's not-so-new Arrow based UDFS (sometimes called `pandas UDFS` or `vectorized UDFs`), there is record batching which can cause issues. You can configure it by changing `spark.sql.execution.arrow.maxRecordsPerBatch`, which defaults to 10k records per batch. If your records are large this default may very well be the source of your out of memory exceptions.


Note: setting `spark.sql.execution.arrow.maxRecordsPerBatch` too-small will result in reduce performance and reduced ability to vectorize operations over the data frames.


### mapInPandas / mapInArrow

If you use `mapInPandas` or `mapInArrow` (proposed in 3.3+) it's important to note that Spark will serialize entire records, not just the columns needed by your UDF. If you encounter OOMs here because of record sizes, one option is to select it down to the minimal data needed to perform the UDF + a key to rejoin with the target dataset to minimize the amount of data being serialized in each record.
