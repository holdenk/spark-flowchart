# Too many tasks

There is some overhead to scheduling tasks. If your tasks are taking less than a minute this is a good sign that you have too many tasks and you may be spending more time scheduling the tasks than you get advantage from. The general solution to this is to either increase `read.split.target-size` if you're reading from Iceberg or repartition your data prior to the transformation down to a smaller number of tasks.
