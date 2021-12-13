# Partial v.s. Full Aggregates

Partial Aggregation is a key concept when handling large amounts of data in Spark. Full aggregation means that all of the data for one key must be together on the same node and then it can be aggregated, whereas partial aggregation allows Spark to start the aggregation "map-side" (e.g. before the shuffle) and then combine these "partial" aggregations together.


In RDD world the classic "full" aggregation is `groupByKey` and partial aggregation is `reduceByKey`.


In DataFrame/Datasets, Scala UDAFs implement partial aggregation but the basic PySpark Panda's/Arrow UDAFs do not support partial aggregation.
