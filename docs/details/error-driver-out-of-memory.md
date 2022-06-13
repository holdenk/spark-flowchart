#Driver ran out of memory

IF you see ```java.lang.OutOfMemoryError:```  in the driver log/stderr, it is most likely from driver JVM running out of memory. [This](https://manuals.netflix.net/view/sparkdocs/mkdocs/master/memory-configuration/#driver-ran-out-of-jvm-memory) article has the memory config for increasing the driver memory. One reason you could run into this error is 
if you are reading from a table with too many splits(s3 files) and overwhelming the driver with a lot of metadata. 


### Check [Spark Memory Configuration](http://go/spark-memory) to narrow down the specific memory component that is causing the OOM errors. 