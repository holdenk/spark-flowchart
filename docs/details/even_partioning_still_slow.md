# Even partioning, but still slow

To see if a stage if evenly partioned take a look the Spark WebUI --> Stage tab and look at the distribution of data sizes and durations of the completed tasks. Sometimes a stage with even parititoning is still slow.


If the max task duration is still substantailly shorter than the stages overall duration, this is often a sign of an insufficient number of executors. Spark can run (at most) `spark.executor.cores * spark.dynamicAllocation.maxExecutors` tasks in parallel (and in practice this will be lower since some tasks will be speculatively executed and some executors will fail). Try increasing the `maxExecutors` and seeing if your job speeds up. Every setting has limitations though. `spark.executor.cores * spark.dynamicAllocation.maxExecutors` should not exceed the cluster capacity. So, try increasing `maxExecutors` within the limitations of the cluster resources and check if the job runtime is faster given the same input data.





If the data is evenly partionined but the max task duration is longer than desired for the stage, increasing the number of executors will not help and you'll need to re-partition the data. See [bad partioning](../bad_partioning).
