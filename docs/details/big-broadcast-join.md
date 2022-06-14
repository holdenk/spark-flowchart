# Too big broadcast joins

Beware that broadcast joins put unnecessary pressure on the driver.  Before the tables are broadcasted to all the executors, the data is brought back to the driver and then broadcasted to executors. So you might run into driver OOMs.


Broadcast smaller tables but this is usually recommended for < 10 Mb tables. Although that is mostly the default, we can comfortably broadcast much larger datasets as long as they fit in the executor and driver memories. Remember if there are multiple broadcast joins in the same stage, you need to have enough room for all those datasets in memory.
You can configure the broadcast threshold using```spark.sql.autoBroadcastJoinThreshold``` or increase the driver memory by setting ```spark.driver.memory``` to a higher value

Make sure that you need more memory on your driver than the sum of all your broadcasted data in any stage plus all the other overheads that the driver deals with!
