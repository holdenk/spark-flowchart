# Too few tasks

If the individual tasks are taking too long to execute, you likely need to increase your partioning. If the data is being read from iceberg you can tune this by decreasing `read.split.target-size`. If your reading from another source you will want to do a shuffle to increase the number of tasks prior to the slow stage.
