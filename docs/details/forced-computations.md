# Force computations

There are multiple use cases where you might want to measure performance for different transformations in your spark job, in which case you have to materialize the transformations by calling an explicit action. If you encounter an exception during the write phase that appears unrelated, one technique is to force computation earlier of the DataFrame or RDD to narrow down the true cause of the exception.


Forcing computation on RDD's is relatively simple, all you need to do is call `count()` and Spark will evaluate the RDD.


Intuitively, we might think that this is the same on RDDs, and the easiest way is to call an action like count() on the dataframe. This might not necessarily work because the optimizer will likely ignore unnecessary transformations. In order to compute the row count, Spark does not have to execute all transformations. The Spark optimizer can simplify the query plan in such a way that the actual transformation that you need to measure will be skipped because it is simply not needed for finding out the final count. In order to make sure all the transformations are called, we need to force Spark to compute them using other ways.

Here are some options to force Spark to compute all transformations of a DataFrame:

* df.rdd.count() : convert to an RDD and perform a count
* df.foreach (_ => ()) : do-nothing foreach 
* Write to an output table (not recommended for performance benchmarking since the execution time will be impacted heavily by the actual writing process)
* If using Spark 3.0 and above, benchmarking is simplified by supporting a "noop" write format which will force compute all transformations without having to write it.
```scala
  df.write
  .mode("overwrite")
  .format("noop")
  .save()
```
