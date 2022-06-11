# Uneven (aka Skewed) partitioning

The most common (and most difficult to fix) bad partitioning in Spark is that of skewed partitioning. The data is not evenly distributed amongst the partitions.  

- Uneven partitioning due to Key-skew  

	The most frequent cause of skewed partitioning is that of ["key-skew."](../key-skew) This happens frequently since humans and machines both tend to cluster resulting in skew (e.g. NYC and `null`).  

- Uneven partitioning due to input layout  

	We are used to thinking of partitioning after a shuffle, but partitioning problems can occur at read time as well. This often happens when the layout of the data on disk is not well suited to our computation. In cases where the RDD or Dataframe doesn't have a particular partitioner, data is partitioned according to the storage on disk. Uneven input partitioned data can be fixed with an explicit repartition/shuffle.  


