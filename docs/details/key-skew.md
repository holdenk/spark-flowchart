# Key/Partition Skew

Key or partition skew is a frequent problem in Spark. Key skew can result in everything from slowly running jobs (with straglers), to failing jobs. Bumping up memory could resolve an OOM error but does not solve the underlying problem.


What causes partition skew?
Certain types of aggregations and windows can result in partitioning the data on a particular key.

1. Usually caused during a transformation when the data in one partition ends up being a lot larger than the others.

2. If processing partitions are unbalanced by an order of magnitude, then the largest partition becomes the bottleneck.
TODO: Is (2) intended to mean partitions created BEFORE a transformation? i.e. do we need both (1) and (2) here?

How to identify skew

1. If one task took much longer to complete than the other tasks, it's usually a sign of skew. On the Spark UI --> Summary Metrics --> Completed Tasks, if the Max task duration is higher by a significant magnitude from the Median task duration, this likely represents skew, e.g.:
![Key-Skew-Spark-UI](../imgs/spark-skewed.png)

Things to consider

1. Mitigating skew has a cost (e.g. repartition) hence skew is ignorable unless the duration or input size is significantly higher in magnitude severely impacting job time.


Mitigation strategies

1. Increasing executor memory to prevent OOM exceptions -> This a short-term strategy if you want to unblock yourself but does not address the underlying issue. Sometimes this approach is not an option when you are already running at the max memory settings allowable. Using this strategy, executors processing the majority of data partitions are over-allocated, potentially earning your job the title "resource-hog." So increase executor memory as a discovery and troubleshooting strategy rather than a "solution."

2. Salting is a way to balance partitions by introducing a salt/dummy key for the skewed partitions. Here is a sample workbook and an example of salting in content performance show completion pipeline, where the whole salting operation is parametrized with a JOIN_BUCKETS variable which helps with maintenance of this job.
![Spark-Salted-UI](../imgs/spark-salted.png)
TODO: what is the link to the workbook? Link to example? Sounds very useful! 

3. Isolate the data for the skewed key, broadcast it for processing (e.g. join) and then union back the results.

4. Adaptive Query Execution is a new framework with Spark 3.0, enabling Spark to dynamically identify skew. Under the hood, adaptive query execution splits (and replicates if needed) skewed (large) partitions. If you don’t want to upgrade to Spark3.x, you can build the solution into your code by using the Salting/Partitioning technique listed above.

5. Using approximate functions/ probabilistic data structure
Approximate distinct counts (Hyperloglog, bloom filter) can help get around skew if absolute precision isn't important.
If you need exact quantiles, check out the example in [High Performance Spark](https://amzn.to/3cmdRw9)

