Large record failures can show up in a few different ways.

For particularly large records you may find an executor out of memory exception


You can get a Kyro serialization (for SQL) or Java serialization error (for RDD).
{%
  include-markdown "../../private/failure-executor-large-record.md"
   start="<!-- start kyro -->"
   end="<!-- end kyro -->"
%}

Some common causes of too big records are `groupByKey` in RDD land, `UDAFs` or list aggregations in Spark SQL, highly compressed or Sparse records without a sparse seriaization.


If you are uncertain of where exactely the too big record is coming from after looking at the executor logs, you can try and seperate the stage which is failing into distinct parts of the code by using `persist` at the `DISK_ONLY` level to introduce cuts into the graph.


If your exception is happening with a Python UDF, it's possible that the individual records themselves might not be too large, but the batch-size used by Spark is set too high for the size of your records. You can try turning down the record size.
