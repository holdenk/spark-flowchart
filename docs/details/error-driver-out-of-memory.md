#Driver ran out of memory

IF you see ```java.lang.OutOfMemoryError:```  in the driver log/stderr, it is most likely from driver JVM running out of memory. [This](https://manuals.netflix.net/view/sparkdocs/mkdocs/master/memory-configuration/#driver-ran-out-of-jvm-memory) article has the memory config for increasing the driver memory. One reason you could run into this error is
if you are reading from a table with too many splits(s3 files) and overwhelming the driver with a lot of metadata.



Another cause for driver out of memory errors is when the number of partitions is too high and you trigger a `sort` or `shuffle` where Spark samples the data, but then runs out of memory while collecting the sample. To solve this `repartition` to a lower number of partitions or if your in RDDs `coalesce` is a more efficent option (in DataFrames coalesce can have impact upstream in the query plan).



