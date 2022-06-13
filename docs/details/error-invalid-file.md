# Missing Files / File Not Found / Reading past RLE/BitPacking stream

Mising files are a relatively rare error in Spark. Most commonly they are caused by non-automic operations in the data writer and will go away when you re-run your query/job.



On the other hand `Reading past RLE/BitPacking stream` or other file read errors tend to be non-transient.
If the error is not transient it may mean that the metadata store (e.g. hive or iceberg) are pointing to a file that does not exist or a bad format. You can cleanup Iceberg tables using [Iceberg Table Cleanup from holden's spark-misc-utils](https://github.com/holdenk/spark-misc-utils), but be careful and talk with whoever produced the table to make sure that it's ok.


If you get a failed to read parquet file while you are not trying to read a parquet file, it's likely that you are using the [wrong metastore](../failed-to-read-non-parquet-file).
