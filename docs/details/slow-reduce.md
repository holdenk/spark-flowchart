# Slow Reduce

Below is a list of reasons why your map stage might be slow. Note that this is not an exhaustive list but covers most of the scenarios.

1. [Not Enough Shuffle Tasks](./Not Enough Shuffle Tasks)
2. [Too many shuffle tasks](./Too many shuffle tasks)
3. [Skewed Shuffle Tasks](./Skewed Shuffle Tasks)
4. [Spill To Disk](./Spill-To-Disk)



### Not Enough Shuffle Tasks

The default shuffle parallelism for our Spark cluster is 500, and it may not be enough for larger datasets. If you don't see skew and most/all of the tasks are taking really long to finish a `reduce` stage, you can improve the overall runtime by increasing the `spark.sql.shuffle.partitions`.

Note that if you are constrained by the resources(reduce tasks are just waiting for resources and not in RUNNING status), you would have to request more executors for your job by increasing ```spark.dynamicAllocation.maxExecutors```

### Too many shuffle tasks

While having too many shuffle tasks has no direct effect on the stage duration, it could slow the stage down if there are multiple retries during the shuffle stage due to shuffle fetch failures. Note that the higher the shuffle partitions, the more chances of running into [FetchFailure](./error-shuffle.md) exceptions.

### Skewed Shuffle Tasks

Partitioning problems are often the limitation of parallelism for most Spark jobs.

There are two primary types of bad partitioning, skewed partitioning (where the partitions are not equal in size/work) or even but non-ideal number partitioning (where the partitions are equal in size/work). If your tasks are taking roughly equivalent times to complete then you likely have even partitioning, and if they are taking unequal times to complete then you may have skewed or uneven partitioning.

[What is skew and how to identify skew](./key-skew.md). Skew is typically from one of the below stages:

* Join: Skew is natural in most of our data sets due to the nature of the data. Both Hash join and Sort-Merge join can run into skew issue if you have a lot of data for one or more keys on either side of the join. Check [Skewed Joins](./slow-skewed-join.md) for handling skewed joins with example.

* Aggregation/Group By: All aggregate functions(UDAFs) using SQL/dataframes/Datasets implement partial aggregation(combiner in MR) so you would only run into a skew if you are using a non-algebraic functions like `distinct` and `percentiles` which can't be computed partially. [Partial vs Full aggregates](./partial_aggregates.md)

* Sort/Repartition/Coalesce before write: It is recommended to introduce an additional stage for `Sort` or `Repartition` or `Coalesce` before the `write` stage to write optimal no. of S3 files into your target table. Check[Skewed Write](./slow-skewed-write.md) for more details.


### Slow Aggregation

Below non-algebraic functions can slow down the `reduce` stage if you have too many values/rows for a given key.

* Count Distinct: Use HyperLogLog(HLL) based sketches for cardinality if you just need the approx counts for trends and don't need the exact counts. HLL can estimate with a standard error of 2%.
* Percentiles: Use approx_percentile or t-digest sketches which would speed up the computation for a small accuracy trade-off.

### Spill To Disk

Spark executors will start using "disk" once they exceed the `spark memory` fraction of executor memory. This it self is not an issue but too much of "spill to disk" will slow down the stage/job. You can overcome this by either increasing the executor memory or tweaking the job/stage to consume less memory.(for ex: a Sort-Merge join requires a lot less memory than a Hash join)
