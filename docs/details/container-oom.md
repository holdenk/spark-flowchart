# Container OOMs




Container OOMs can be difficult to debug as the container running the problematic code is killed, and sometimes not all of the log information is available.


Non-JVM language users (such as Python) are most likely to encounter issues with container OOMs. This is because the JVM is _generally_ configured to not use more memory than the container it is running in.


Everything which isn't inside the JVM is considered "overhead", so Tensorflow, Python, bash, etc. A first step with a container OOM is often increasing `spark.executor.memoryOverhead` and `spark.driver.memoryOverhead` to leave more memory for non-Java processes.


Python users can set `spark.executor.pyspark.memory` to limit the Python VM to a certain amount of memory. This amount of memory is then added to the overhead.
