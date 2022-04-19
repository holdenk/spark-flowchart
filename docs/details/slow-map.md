# Slow Map 


Below is a list of reasons why your map stage might be slow. Note that this is not an exhaustive list but covers most of the scenarios.

1. [Reading more data than needed](./Reading-more-data-than-needed)
2. [Not enough Read/Map Tasks](./Not-enough-Read/Map-Tasks)
3. [Too many Read/Map Tasks](./Too-many-Read/Map-Tasks)
4. [Slow Transformations](./Slow-Transformations)
5. [Skewed Map Tasks](./Skewed-Map-Tasks)



### Reading more data than needed

Iceberg/Parquet provides 3 layers of data pruning/filtering, so it is recommended to make the most of it by utilizing them as upstream in your ETL as possible.  

* Partition Pruning : Applying a filter on a partition column would mean the Spark can prune all the partitions that are not needed (ex: utc_date, utc_hour etc.). Refer to [this](./slow-partition_filter_pushdown.md) section for some examples.
* Column Pruning : Most of our DW tables are in parquet which is a columnar format which allows us to read specific columns from a row group without having to read the entire row. By selecting the fields that you only need for your job/sql(instead of "select *"), you can avoid bringing unnecessary data only to drop it in the subsequent stages. 
* Predicate Push Down: It is also recommended to use filters on non-partition columns as this would allow Spark to exclude specific row groups while reading data from S3. For ex: ```account_id is not null``` if you know that you would be dropping the NULL account_ids eventually.   


### Not enough Read/Map Tasks

If your map stage is taking longer, and you are sure that you are not reading more data than needed, then you may be reading the data with small no. of tasks. You can increase the no. of map tasks by decreasing [target split size](https://manuals.netflix.net/view/Iceberg/mkdocs/master/properties/#spark-configuration). Note that if you are constrained by the resources(map tasks are just waiting for resources and not in RUNNING status), you would have to request more executors for your job by increasing ```spark.dynamicAllocation.maxExecutors``` 

### Too many Read/Map Tasks

If you have large no. of map tasks in your stage, you could run into driver memory related errors as the task metadata could overwhelm the driver. This also could put a stress on shuffle(on map side) as more map tasks would create more shuffle blocks. It is recommended to keep the task count for a stage under 80k.  You can decrease the no. of map tasks by increasing [target split size](https://manuals.netflix.net/view/Iceberg/mkdocs/master/properties/#spark-configuration) for an Iceberg table. (Note: For a non-iceberg table, the property is ```spark.sql.maxPartitionBytes``` and it is at the job level and not at the table level)  

### Slow Transformations

Another reason for slow running map tasks could be from one fo the 3 reasons:

* Regex : You have `RegEx` in your transformation.  Refer to [RegEx tips](./slow-regex-tips.md) for tuning. 
* udf: Make sure you are sending only the data that you need in UDF and tune UDF for performance. Refer to [Slow UDF](./udfslow.md) for more details. 
* Json: 
  
All these transformations may run into skew issues if you have a single row/column that is bloated. You could prevent this by checking the payload size before calling the transformation as a single row/column could potentially slow down the entire stage. 


### Skewed Map Tasks

In general, Map stage is not skewed because Spark tried to combine the smaller splits into one task until it reaches a target size and also divides a bigger split into multiple tasks if the split is too big.


* Record Skew : A single bloated row/record could be the root cause for slow map task. The easiest way to identify this is by checking your string fields that has Json payload. ( Ex: A bug in a client could write a lot of data). You can identify the culprit by checking the max(size/length) of the field in your upstream table. For CL, `snapshot` is a candidate for bloated field.    

* Task Skew : **This is only applicable to the tables with non-splittable file format(like TEXT, zip) and parquet files should never run into this issue. Task skew is where one of the tasks got more rows than others and it is possible  if the upstream table has a single file that is large and has the non-splittable format.