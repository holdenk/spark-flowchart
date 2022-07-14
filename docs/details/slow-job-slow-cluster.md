### Slow Cluster

How do I know if and when my job is waiting for cluster resources??


Sometimes the cluster manager may choke or otherwise not be able to allocate resources and we don't have a good way of detecting this situation making it difficult for the user to debug and tell apart from Spark not scaling up correctly.

As of Spark3.4, an executor will note when and for how long it waits for cluster resources. Check the JVM metrics for this information. 

### Reference link: 
https://issues.apache.org/jira/browse/SPARK-36664
