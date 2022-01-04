# Too Big DAG (or when iterative algorithms go bump in the night)

Spark uses lazy evaluation and creates a DAG (directed acyclic graph) of the operations needed to compute a peice of data. Even if the data is persisted or cached, Spark will keep this DAG in memory on the driver so that if an executor fails it can re-create this data later. This is more likely to cause problems with iterative algorithms that create RDDs or DataFrames on each iteration based on the previous iteration, like ALS. Some signs of a DAG getting too big are:

- Iterative algorithm becoming slower on each iteration
- Driver OOM
- Executor out-of-disk-error


If your job hasn't crashed, an easy way to check is by looking at the Spark Web UI and seeing what the DAG visualization looks like. If the DAG takes a measurable length of time to load (minutes), or fills a few screens it's likely "too-big."



Working around this can be complicated, but there are some tools to simplify it. The first is Spark's `checkpointing` which allows Spark to "forget" the DAG so far by writing the data out to a persistent storage like S3 or HDFS. The second is manually doing what checkpointing does, that is on your own writing the data out and loading it back in.


Unfortunately, if you work in a notebook environment this might not be enough to solve your problem. While this will introduce a "cut" in the DAG, if the old RDDs or DataFrames/Datasets are still in scope they will still continue to reside in memory on the driver, and any shuffle files will continue to reside on the disks of the workers. To work around this it's important to explicitly clean up your old RDDs/DataFrames by setting their references to None/null.


If you still run into executor out of disk space errors, you may need to look at the approach taken in Spark's ALS algorithm of triggering eager shuffle cleanups, but this is an advanced feature and can lead to non-recoverable errors.
