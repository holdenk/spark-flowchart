# Executor out of disk error

By far the most common cause of executor out of disk errors is a mis-configuration of Spark's temporary directories.


You should set `spark.local.dir` to a directory with lots of local storage available. If you are on YARN this will be overriden by `LOCAL_DIRS` environment variable on the workers.


Kubernetes users may wish to add a large `emptyDir` for Spark to use for temporary storage.


Another common cause is having no longer needed/used RDDs/DataFrames/Datasets in scope. This tends to happen more often with notebooks as more things are placed in the global scope where they are not automatically cleaned up. A solution to this is breaking your code into more functions so that things go out of scope, or explicitily setting no longer needed RDDs/DataFrames/Datasets to None/null.


On the other hand if you have an iterative algorithm you should investigate [../toobigdag](if you may have too big of a DAG).
