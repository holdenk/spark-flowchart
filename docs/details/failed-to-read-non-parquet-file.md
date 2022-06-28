# Failed to read non-parquet file

Iceberg does not perform validation on the files specified, so it will let you create a table pointing to non-supported formats, e.g. CSV data, but will fail at query time. In this case you need to use a different metastore (e.g. `Hive`)



If the data is stored in a supported format, it is also possible you have an invalid iceberg table.
