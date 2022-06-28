# Fetch Failed exceptions

## No time to read, help me now.

FetchFailed exceptions are mainly due to misconfiguration of ```spark.sql.shuffle.partitions```:

1. Too few shuffle partitions: Having too few shuffle partitions means you could have a shuffle block that is larger than the limit(Integer.MaxValue=~2GB) or OOM(Exit code 143). The symptom for this can also be long-running tasks where the blocks are large but not reached the limit. A quick fix is to increase the shuffle/reducer parallelism by increasing ```spark.sqlshuffle.partitions```(default is 500).
2. Too many shuffle partitions: Too many shuffle partitions could put a stress on the shuffle service and could run into errors like ```network timeout``` ```. Note that the shuffle service is a shared service for all the jobs running on the cluster so it is possible that someone else's job with high shuffle activity could cause errors for your job. It is worth checking to see if there is a pattern of these failures for your job to confirm if it is an issue with your job or not. Also note that the higher the shuffle partitions, the more likely that you would see this issue.


## Tell me more.

FetchFailed Exceptions can be bucketed into below 4 categories:

1. Ran out of heap memory(OOM) on an Executor
2. Ran out of overhead memory on an Executor
3. Shuffle block greater than 2 GB
4. Network TimeOut.

### Ran out of heap memory(OOM) on an Executor

This error indicates that the executor hosting the shuffle block has crashed due to Java OOM. The most likely cause for this is misconfiguration of ```spark.sqlshuffle.partitions```. A workaround is to increase the shuffle partitions. Note that if you have skew from a single key(in join, group By), increasing this property wouldn't resolve the issue. Please refer to [key-skew](../key-skew) for related workarounds.

Errors that you normally see in the executor/task logs:

* ExecutorLostFailure due to Exit code 143
* ExecutorLostFailure due to Executor Heartbeat timed out.



### Ran out of overhead memory on an Executor

This error indicates that the executor hosting the shuffle block has crashed due to off-heap(overhead) memory. Increasing ```spark.yarn.executor.Overhead``` should prevent this specific exception.

Error that you normally see in the executor/task logs:

* ExecutorLostFailure, # GB of # GB physical memory used. Consider boosting the spark.yarn.executor.Overhead


### Shuffle block greater than 2 GB

The most likely cause for this is misconfiguration of ```spark.sqlshuffle.partitions```. A workaround is to increase the shuffle partitions(increases the no.of blocks and reduces the block size). Note that if you have skew from a single key(in join, group By), increasing this property wouldn't resolve the issue. Please refer to [key-skew](../key-skew) for related workarounds.

Error that you normally see in the executor/task logs:

* Too Large Frame
* Frame size exceeding
* size exceeding Integer.MaxValue(~2GB)


### Network Timeout

The most likely cause for this exception is a high shuffle activity(high network load) in your job. Reducing the shuffle partitions ```spark.sqlshuffle.partitions``` would mitigate this issue. You can also reduce the network load by modifying the shuffle config. (todo: add details)

Error that you normally see in the executor/task logs:

* org.apache.spark.shuffle.MetadataFetchFailedException: Missing an output location for shuffle 0
* org.apache.spark.shuffle.FetchFailedException: Failed to connect to ip-xxxxxxxx
* Caused by: org.apache.spark.shuffle.FetchFailedException: Too large frame: xxxxxxxxxxx
