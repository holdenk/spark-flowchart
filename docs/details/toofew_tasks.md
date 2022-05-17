# Too few tasks

If the individual tasks are taking too long to execute, you likely need to increase the number of partitions. If the data is being read from Iceberg you can tune this by decreasing `read.split.target-size`. If you're reading from another source you will want to do a shuffle to increase the number of tasks prior to the slow stage.
