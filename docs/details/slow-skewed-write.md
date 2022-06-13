# Skewed/Slow Write


Writes can be slow depending on the preceding stage of `write()`, target table partition scheme, and write parallelism(`spark.sql.shuffle.partitions`). 
The goal of this article is to go through below options and see the most optimal transformation for writing optimal files in target table/partition. 


### When to use Sort

A global sort in Spark internally uses range-partitioning to assign sort keys to a partition range. This involves in collecting sample rows(reservoir sampling) from input partitions and sending them to the driver for computing range boundaries. 

Use global `sort` 

* If you are writing multiple partitions(especially heterogeneous partitions) as part of your write() as it can estimate the no. of files/tasks for a given target table partition based on the no. of sample rows it observes.
* If you want to enable `predicate-push-down` on a set of target table fields for down stream consumption.

Tips:
1. You can increase the spark property `spark.sql.execution.rangeExchange.sampleSizePerPartition` to improve the estimates if you are not seeing optimal no. of files per partition.
2. You can also introduce `salt` to sort keys to increase the no. of write tasks if the sort keys cardinality less than the `spark.sql.shuffle.partitions`. [Example](https://stash.corp.netflix.com/projects/SDE/repos/cdn-analytics/browse/src/main/scala/dea/cdn/spark/jobs/CdnAtlasPipeline.scala#112)


### When to use Repartition

Repartition(hash partitioning) partitions rows in a round-robin manner and to produce uniform distribution across the tasks and a hash partitioning just before the `write` would produce uniform files and all write tasks should take about the same time.

Use `repartition`

* If you are writing into a single partition or a non-partitioned table and want to get uniform file sizes.
* If you want to produce a specific no.o files. for ex: using `repartiton(100)` would generate up to 100 files.


### When to use Coalesce

Coalesce tries to combine files without invoking a shuffle and useful when you are going from a higher parallelism to lower parallelism. Use Coalesce:

* If you are writing very small no. of files and the file size is relatively small. 

Note that, Coalesce(N) is not an optimal way to merge files as it tries to combine multiple files(until it reaches target no. of files 'N' ) without taking size into equation, and you could run into ```(org.apache.spark.memory.SparkOutOfMemoryError: Unable to acquire 65536 bytes of memory, got 0) ``` if the size exceeds.   




