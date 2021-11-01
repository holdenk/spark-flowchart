# Bad partioning

There are three main different types and causes of bad partioning in Spark. Partioning is often the limitation of parallelism for most Spark jobs.


The most common (and most difficult to fix) bad partioning in Spark is that of skewed partioning. With key-skew the problem is not the number of partions, but that the data is not evenly distributed amongst the partions. The most frequent cause of skewed partioning is that of ["key-skew."](../key-skew). This happens frequently since humans and machines both tend to cluster resulting in skew (e.g. NYC and `null`).


The other type of skewed partioning comes from "input partioned" data which is not evenly partioned. With input partioned data, the RDD or Dataframe doesn't have a particular partioner it just matches however the data is stored on disk. Uneven input partioned data can be fixed with an explicit repartion/shuffle.


Insufficent partioning is similar to input skewed partioning, except instead of skew there just are not enough partions. Similarily you  the number of partions (e.g. `repartion(5000)` or change `spark.sql.shuffle.partitions`).
