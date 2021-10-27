Executor out of memory issues can come from many different sources. To narrow down what the cause of the error there are a few important places to look: the Spark Web UI, the executor log, the driver log, and (if applicable) the cluster manager (e.g. YARN/K8s) log/UI.


## Container OOM

If the driver log indicates `Container killed by YARN for exceeding memory limits` for the applicable executor, or if (on K8s) the Spark UI show's the reason for the executor loss as "OOMKill" / exit code 137 then it's likely your program is exceeding the amount of memory assigned to it. This doesn't normally happen with pure JVM code, but instead when calling PySpark or JNI libraries (or using off-heap storage).


PySpark users are the most likely to encounter container OOMs. If you have PySpark UDF in the stage you should check out [Python UDF OOM](failure-pyspark-udf.html) to eliminate that potential cause. Another potential issue to investigate is if your have [key skew](key-skew.html) as trying to load too large a partition in Python can result in an OOM. If you are using a library, like Tensorflow, which results in
