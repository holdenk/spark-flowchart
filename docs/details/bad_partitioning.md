# Bad Partitioning

Bad partitioning in Spark is frequently caused by either skew or too few partitions. Partitioning is often the limitation of parallelism for most Spark jobs.  

- Skewed Partitioning  
The most common (and most difficult to fix) bad partitioning in Spark is that of skewed partitioning. The data is not evenly distributed amongst the partitions. 
	* Key-skew  
	The most frequent cause of skewed partitioning is that of ["key-skew."](../key-skew) This happens frequently since humans and machines both tend to cluster resulting in skew (e.g. NYC and `null`).  

	* Uneven input partitioning  
	In cases where the RDD or Dataframe doesn't have a particular partitioner, data is partitioned according to the storage on disk. Uneven input partitioned data can be fixed with an explicit repartition/shuffle.  

- Too few partitions  
Insufficient partitioning can be fixed by increasing the number of partitions (e.g. `repartition(5000)` or change `spark.sql.shuffle.partitions`).  

If you identify one item above is causing partition problems, consider checking the other items as well.

