# Even Partitioning Yet Still Slow

To see if a stage if evenly partitioned take a look at the Spark WebUI --> Stage tab and look at the distribution of data sizes and durations of the completed tasks. Sometimes a stage with even partitioning is still slow.

There are a few common possible causes when the partitioning is even for slow stages. If your tasks are too short (e.g. finishing in under a few minutes), likely you have too many partitions/tasks. If your tasks are taking just the right amount of time but your jobs are slow you may not have enough executors. If your tasks are taking a long time you may have too large records, not enough partitions/tasks, or just slow functions. Another sign of not enough tasks can be excessive spill to disk.



If the data is evenly partitioned but the max task duration is longer than desired for the stage, increasing the number of executors will not help and you'll need to re-partition the data. Insufficient partitioning can be fixed by increasing the number of partitions (e.g. `repartition(5000)` or change `spark.sql.shuffle.partitions`).


Another cause of too large partitioning can be non-splittable compression formats, like gzip, that can be worked around with tools like [splittablegzip](https://github.com/nielsbasjes/splittablegzip).
