# Slow writes due to Too many small files
Sometimes a partitioning approach works fine for a small dataset, but can cause a surprisingly large number of partitions for a slighly larger dataset. Check out The Small File Problem in context of HDFS.  



# Relevant links 

HDFS: 
[The Small File Problem: Partition strategies to avoid IO limitations](https://medium.com/airbnb-engineering/on-spark-hive-and-small-files-an-in-depth-look-at-spark-partitioning-strategies-a9a364f908)
