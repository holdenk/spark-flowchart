# Bad Partitioning

There are three main different types and causes of bad partitioning in Spark. Partitioning is often the limitation of parallelism for most Spark jobs.


1. The most common (and most difficult to fix) bad partitioning in Spark is that of skewed partitioning. With key-skew the problem is not the number of partitions, but that the data is not evenly distributed amongst the partitions. The most frequent cause of skewed partitioning is that of ["key-skew."](../key-skew). This happens frequently since humans and machines both tend to cluster resulting in skew (e.g. NYC and `null`).


2. The other type of skewed partitioning comes from "input partitioned" data which is not evenly partitioned. With input partitioned data, the RDD or Dataframe doesn't have a particular partitioner; rather, the partitions just match however the data is stored on disk. Uneven input partitioned data can be fixed with an explicit repartition/shuffle.


3. Insufficent partitioning is similar to input skewed partitioning, except instead of skew there just are not enough partitions. Insufficient partitioning can be fixed by increasing the number of partitions (e.g. `repartition(5000)` or change `spark.sql.shuffle.partitions`).
