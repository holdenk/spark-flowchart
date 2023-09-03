#Driver ran out of memory

IF you see ```java.lang.OutOfMemoryError:```  in the driver log/stderr, it is most likely from driver JVM running out of memory. One reason you could run into this error is
if you are reading from a table with too many splits(s3 files) and overwhelming the driver with a lot of metadata.



Another cause for driver out of memory errors is when the number of partitions is too high and you trigger a `sort` or `shuffle` where Spark samples the data, but then runs out of memory while collecting the sample. To solve this `repartition` to a lower number of partitions or if you're in RDDs `coalesce` is a more efficent option (in DataFrames coalesce can have impact upstream in the query plan).


A less common, but still semi-frequent, occurnce of driver out of memory is an excessive number of tasks in the UI. This can be controlled by reducing `spark.ui.retainedTasks` (default 100k).


