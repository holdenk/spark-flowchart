# Partition at read time

We're used to thinking of partitioning after a shuffle, but partitioning problems can occur at read time as well. This often happens when the layout of the data on disk is not well suited to our computation. Note that the number of partitions can be optionally specified when using the read API. 

How to decide on a partition column or partition key?

1. Does the key have relatively low cardinality?
1k distinct values are better than 1M distinct values. 
Consider a numeric, date, or timestamp column. 

2. Does the key have enough data in each partition?
> 1Gb is a good goal. 

3. Does the key have too much data in each partition? 
The data must fit on a single task in memory and avoid spilling to disk. 

4. Does the key have evenly distributed data in each partition?
If some partitions have orders of magnitude more data than others, those larger partitions have the potential to spill to disk, OOM, or simply consume excess resources in comparison to the partitions with median amounts of data. You don't want to size executors for the bloated partition. If none of the columns or keys has a particularly even distribution, then create a new column at the expense of saving a new version of the table/RDD/DF. A frequent approach here is to create a new column using a hash based on existing columns. 

5. Does the key allow for fewer wide transformations?
Wide transformations are more costly than narrow transformations. 

6. Does the number of partitions approximate 2-3x the number of allocated cores on the executors?

# Reference links
[Learning Spark](https://www.oreilly.com/library/view/learning-spark-2nd/9781492050032/)
[High Performance Spark](https://www.oreilly.com/library/view/high-performance-spark/9781491943199/)
