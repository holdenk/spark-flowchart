# Not enough executors

If the max task duration is substantailly shorter than the stages overall duration, this is often a sign of an insufficient number of executors. Spark can run (at most) `spark.executor.cores * spark.dynamicAllocation.maxExecutors` tasks in parallel (and in practice this will be lower since some tasks will be speculatively executed and some executors will fail). Try increasing the `maxExecutors` and seeing if your job speeds up.

!!! note
	Setting `spark.executor.cores * spark.dynamicAllocation.maxExecutors` in excess of cluster capacity can result in the job waiting in PENDING state. So, try increasing `maxExecutors` within the limitations of the cluster resources and check if the job runtime is faster given the same input data.
