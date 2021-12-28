# Bringing too much data back to the driver (collect and friends)

A common anti-pattern in Apache Spark is using `collect()` and then processing records on the driver. There are a few different reasons why folks tend to do this and we can work through some alternatives:

- Label items in ascending order
	* ZipWithIndex
- Index items in order
	* Compute the size of each partition use this to assign indexes.
- In order processing
	* Compute a partition at a time (this is annoying to do, sorry).
- Writing out to a format not supported by Spark
	* Use `foreachPartition` or implement your own DataSink.
- Need to aggregate everything into a single record
	* Call `reduce` or `treeReduce`


Sometimes you do really need to bring the data back to the driver for some reason (e.g., updating model weights). In those cases, especially if you process the data sequentially, you can limit the amount of data coming back to the driver at one time. `toLocalIterator` gives you back an iterator which will only need to fetch a partion at a time (although in Python this may be pipeline for efficency). By default `toLocalIterator` will launch a Spark job for each partition, so if you know you will eventually need all of the data it makes sense to do a `persist` + a `count` (async or otherwise) so you don't block as long between partions.


This doesn't mean every call to `collect()` is bad, if the amount of data being returned is under ~1gb it's probably _OK_ although it will limit parallelism.
