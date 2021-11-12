# Slow executor

There can be many reasons executors are slow, here are a few things you can look into:
- Performance distribution among tasks in the same stage: In Spark UI - Stages - Summary Metric: check if there's uneven distribution of 
  duration / input size, if so there may be data skews or uneven partition splits.
- Task size: In Spark UI - Stages - Summary Metrics, check the input/output size of tasks, usually it's reasonable with a few hundred megabytes
  per task. If too big, you may need to increase parallel level by configurations like spark.sql.shuffle.partitions, spark.sql.files.maxPartitionBytes
- GC: Check if GC time is a small fraction of duration, if it's more than a few percents, try increase executor memory and see if any difference.
  If adding memory is not helping, you can now see if any optimization can be done in your code for that stage.