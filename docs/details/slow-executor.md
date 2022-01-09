# Slow executor

There can be many reasons executors are slow; here are a few things you can look into:
- Performance distribution among tasks in the same stage: In Spark UI - Stages - Summary Metric: check if there's uneven distribution of 
  duration / input size. If true, there may be data skews or uneven partition splits. See [bad partitioning](../bad_partitioning).
- Task size: In Spark UI - Stages - Summary Metrics, check the input/output size of tasks. If individual input or output tasks are larger than a few hundred megabytes, you may need more partitions. Try increasing spark.sql.shuffle.partitions or spark.sql.files.maxPartitionBytes or consider making a repartition call.
- GC: Check if GC time is a small fraction of duration, if it's more than a few percents, try increase executor memory and see if any difference.
  If adding memory is not helping, you can now see if any optimization can be done in your code for that stage.
