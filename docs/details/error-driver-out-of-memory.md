#Driver ran out of memory

### Symptom
I see ```java.lang.OutOfMemoryError:```  in the driver log/stderr

OOMs can happen during different stages of the Spark app.

### Potential cause: too many splits on read

If you see ```java.lang.OutOfMemoryError:```  in the driver log/stderr, it is most likely from driver JVM running out of memory. [This](https://manuals.netflix.net/view/sparkdocs/mkdocs/master/memory-configuration/#driver-ran-out-of-jvm-memory) article has the memory config for increasing the driver memory. One reason you could run into this error is if you are reading from a table with too many splits(s3 files) and overwhelming the driver with a lot of metadata. So adjust the driver memory as a band-aid, and consider fewer splits and other ways to reduce memory consumption as a short term fix.


### Potential cause: OOM while running a `collect` action

Check if you're running a `collect` or similar action, which is a frequent cause of driver OOMs as `collect` sends the entire RDD or DF to the driver. If you must collect the entire dataset to the driver, reduce the input dataset to a size that fits into the driver memory. [This](https://databricks.gitbooks.io/databricks-spark-knowledge-base/content/best_practices/dont_call_collect_on_a_very_large_rdd.html) article has a couple more suggestions.


### Potential cause: OOM while sampling data

Another potential cause for ```java.lang.OutOfMemoryError:``` could be the driver runs out of memory while obtaining a data sample. Perhaps you're working with an RDD or DF in which the number of partitions is too high (eg 20,000) and you trigger a `sort` or `shuffle` where Spark samples some data from each partition. In this case the driver can run out of memory while sampling the data even though your code does NOT `collect` the entire dataset to the driver. To solve this `repartition` to a lower number of partitions. Coalesce would be a good option if you're using RDDs. However if you're using DataFrames, coalesce might not be the best option as coalesce can have impacts upstream in the query plan.


These are three of the common causes for driver OOMs. Submit your (least) favorite driver OOM to the Spark-Flowchart for inclusion here!
